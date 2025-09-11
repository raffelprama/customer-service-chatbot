import uuid
import logging

from fastapi import APIRouter, HTTPException, status
from typing import Optional, List
from server.schemas.history_db_shacme import HistoryResponse, HistoryAllResponse
from fastapi import Query, HTTPException, APIRouter

# Impor fungsi database yang sudah kita diskusikan
from server.service.history_db_service import save_message, HistoryService

logger = logging.getLogger(__name__)

history_router = APIRouter()


@history_router.post("/history", response_model=HistoryResponse, tags=["History"])
async def post_history(
    user_id: Optional[str] = Query(default=None, description="user_id Input"),
    message_text: Optional[str] = Query(default=None, description="text Input"),
    message_role: Optional[str] = Query(default=None, description="role Input")
    ):
    """
    Saves a new chat message to the database.
    This endpoint is a utility for the chat system's internal use.
    """
    try:
        # Validasi user_id untuk memastikan formatnya benar
        user_id_uuid = uuid.UUID(user_id)
    except ValueError:
        raise HTTPException(
            status_code=status.HTTP_400_BAD_REQUEST,
            detail="Invalid user_id format. Must be a valid UUID."
        )

    # Validasi message_role
    if message_role not in ["user", "assistant", "tool"]:
        raise HTTPException(
            status_code=status.HTTP_400_BAD_REQUEST,
            detail="Invalid message_role. Must be 'user', 'assistant', or 'tool'."
        )

    try:
        # Panggil fungsi database untuk menyimpan pesan
        save_message(
            user_id=str(user_id_uuid),
            message_text=message_text,
            message_role=message_role
        )

        logger.info(f"Message saved for user {user_id} with role '{message_role}'.")
        return {
            "message": "Chat history saved successfully.",
            "message_id": str(uuid.uuid4())
        }

    except Exception as e:
        logger.error(f"Error saving chat history: {e}")
        raise HTTPException(
            status_code=status.HTTP_500_INTERNAL_SERVER_ERROR,
            detail=f"An error occurred while saving chat history: {str(e)}"
        )



@history_router.get("/all", response_model=HistoryAllResponse, tags=["History"])
async def get_all_history():
    """
    get all history data
    """
    try:
        historys = HistoryService.get_all_history()
        
        return {
            "results": [history.to_dict() for history in historys],
        }
        
    except Exception as e:
        logger.error(f"Error getting history: {e}")
        raise HTTPException(status_code=500, detail=str(e))
    

@history_router.get("/head-5", response_model=HistoryAllResponse, tags=["History"])
async def fetch_last_messages(
    user_id: Optional[str] = Query(default=None, description="user_id Input"),
    count: Optional[int] = Query(default=5, description="count Input")
    ):
    """
    get the last 5 history data
    """
    try:
        historys = HistoryService.fetch_last_messages(user_id, count)
        return {"results": historys}
        
    except Exception as e:
        logger.error(f"Error getting history: {e}")
        raise HTTPException(status_code=500, detail=str(e))