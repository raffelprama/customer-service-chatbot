import logging

from fastapi import APIRouter,Depends
from typing import Optional,List
from dotenv import load_dotenv
from fastapi import FastAPI, Query, HTTPException, APIRouter

from server.schemas.chat_schema import Item, ChatResponse
from server.service.chat_service import ChatRunner
from server.routes.history_db import post_history

logger = logging.getLogger(__name__)
load_dotenv()
chat_router = APIRouter()

@chat_router.post("/chat/completions", response_model=ChatResponse, tags=["Chat"])
async def chat_completion(
        prompt: Optional[str] = Query(default=None, description="Question Input"),
        user_id: Optional[str] = Query(default=None, description="User id Input")
):
    """
    Chat input using Ollama LLM
    """
    try:
        logger.info("starting process chat")

        result = ChatRunner.run_chat(
            prompt=prompt,
            user_id=user_id
        )

        await post_history(user_id, prompt, "user")
        await post_history(user_id, result["output"], "assistant")

        logger.info(f"user {user_id} chat output : {result['output']}")

        return result
    except Exception as e:
        logger.error(f"Error in chat_completion: {e}")
        raise HTTPException(status_code=500, detail=str(e))