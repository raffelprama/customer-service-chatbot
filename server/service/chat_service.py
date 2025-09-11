import logging
import os
import ollama
import uuid

from typing import Dict, Any
from dotenv import load_dotenv
from datetime import datetime, timezone

from server.service.ollama_service import ollama_model

load_dotenv()
logger = logging.getLogger(__name__)

class ChatRunner:
    """
    Service class to run chat
    """
    @staticmethod
    def run_chat(prompt: str, user_id: str) -> Dict[str, Any]:
        """
        Validate if the target URL is accessible
        """
        try:
            ollama_host = os.getenv("OLLAMA_HOST", "http://127.0.0.1:11434")
            logger.info(f"Using Ollama host: {ollama_host}")
            os.environ["OLLAMA_HOST"] = ollama_host  

            response = ollama_model(prompt, user_id=user_id)
            return response
        except Exception as e:
            logger.error(f"Chat Process failed: {e}")
            return {
                "id": str(uuid.uuid4()),
                "createAt": datetime.now(timezone.utc),
                "output": f"Error: {e}"
            }