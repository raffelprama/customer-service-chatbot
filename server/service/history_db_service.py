import psycopg2
import logging

from server.schemas.history_db_shacme import HistoryResult
from typing import List, Dict

from server.database.db import get_db_connection

logger = logging.getLogger(__name__)

def save_message(user_id: str, message_text: str, message_role: str) -> None:
    """
    Saves a single chat message into the chat_history table.
    
    Args:
        user_id (str): The unique ID of the user.
        message_text (str): The text content of the message.
        message_role (str): The role of the message sender ('user', 'assistant', or 'tool').
    """
    try:
        insert_query = """
        INSERT INTO chat_history (user_id, message_text, message_role)
        VALUES (%s, %s, %s);
        """
        
        with get_db_connection() as conn:
            with conn.cursor() as cur:
                cur.execute(insert_query, (user_id, message_text, message_role))
                conn.commit()
                
        logger.info(f"Successfully saved message for user {user_id} with role '{message_role}'.")
        
    except (psycopg2.Error, Exception) as e:
        logger.error(f"Failed to save message to database: {e}")
        raise

class HistoryService:
    user_id: str
    message_text: str
    message_role: str

    @staticmethod
    def get_all_history():
        """Get all history results with pagination"""
        try:
            # Get paginated results
            select_query = """
            SELECT * FROM chat_history
            ORDER BY id DESC
            """
            
            with get_db_connection() as conn:
                with conn.cursor() as cursor:
                    # Get paginated results
                    cursor.execute(select_query)
                    rows = cursor.fetchall()
                    
                    history = [HistoryResult.from_db_row(row) for row in rows]
                    return history
                    
        except Exception as e:
            logger.error(f"Error getting all history: {e}")
            raise
    
    @staticmethod
    def fetch_last_messages(user_id: str, count: int = 5) -> List[Dict[str, str]]:
        """Get all history results with pagination"""
        try:
            select_query = """
            SELECT message_text, message_role
            FROM chat_history
            WHERE user_id = %s
            ORDER BY timestamp DESC
            LIMIT %s;
            """
            
            with get_db_connection() as conn:
                with conn.cursor() as cursor:
                    cursor.execute(select_query, (user_id, count))
                    rows = cursor.fetchall()
                    
                    history = [
                        {"role": row['message_role'], "content": row['message_text']}
                        for row in reversed(rows)
                    ]
                    return history
                    
        except Exception as e:
            logger.error(f"Error getting all history: {e}")
            raise