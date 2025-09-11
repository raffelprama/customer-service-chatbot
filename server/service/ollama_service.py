import ollama
import uuid
import json
import logging

from datetime import datetime, timezone

from server.utils.tools import tools
from server.utils.model import fetch_products, recent_chat

def ollama_model(prompt: str, user_id: str):

    camera_data = fetch_products()
    history_data = recent_chat(user_id=user_id)

    system_prompt = f"""
    You are a helpful assistant that focuses on helping customer service to sell cameras.
    Always provide short, clear, and objective answers. 
    Include a greeting at the beginning and a thank you at the end, and if there is a memory of their name keep their name.
    Do not add unnecessary explanations unless asked.
    
    And you can get all this data to help answer if correlated with items:
    Here's the data of cameras: {json.dumps(camera_data, indent=2)}
    Here's the last chat: {json.dumps(history_data, indent=2)}

    You have access to the following tools:
    - get_user('{user_id}') call this tool if there is correlation with what or where the status or the product/process they bought
    - get_garansi() call this tool when the user is asking about warranty or garansi or how to claim it
    """

    logging.info(f"\n\n===denbug 1===\n{system_prompt}\n")


   # Step 1: Ask LLM with tool schemas
    response = ollama.chat(
        model="llama3.2:3b",
        messages=[
            {"role": "system", "content": system_prompt},
            {"role": "user", "content": prompt}
        ],
        tools=[
            {
                "type": "function",
                "function": {
                    "name": "get_user",
                    "description": "Fetch user information by user_id",
                    "parameters": {
                        "type": "object",
                        "properties": {"user_id": {"type": "string"}},
                        "required": ["user_id"],
                    },
                },
            },
            {
                "type": "function",
                "function": {
                    "name": "get_garansi",
                    "description": "Fetch garansi (warranty) information",
                    "parameters": {"type": "object", "properties": {}},
                },
            },
        ]
    )
    logging.info(f"\n\n===denbug 2===\n{response}\n")
    logging.info(f"\n\n===denbug 3===\n{tools}\n")

    # Step 2: Check if LLM requested a tool
    message = response.message  # This is the Message object

    if message.tool_calls:
        for tool_call in message.tool_calls:
            tool_name = tool_call.function.name
            tool_args = tool_call.function.arguments
            logging.info(f"\n===Tool Call===\nName: {tool_name}, Args: {tool_args}\n")

            if tool_name in tools:
                tool_result = tools[tool_name](**tool_args)
                logging.info(f"\n===Tool Result===\n{tool_result}\n")

                # Send back to model
                followup = ollama.chat(
                    model="llama3.2:3b",
                    messages=[
                        {"role": "system", "content": system_prompt},
                        {"role": "user", "content": prompt},
                        {"role": "assistant", "tool": {"name": tool_name, "arguments": tool_args}},
                        {"role": "tool", "content": json.dumps(tool_result)},
                    ]
                )
                msg = followup.message.content
            else:
                msg = message.content
    else:
        msg = message.content

    return {
        "id": str(uuid.uuid4()),
        "createAt": datetime.now(timezone.utc).isoformat(),
        "output": msg
    }

# === Example Run ===
if __name__ == "__main__":
    result = ollama_model("prompt", "user_id")
    print(result)
