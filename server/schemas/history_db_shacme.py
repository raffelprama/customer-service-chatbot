from pydantic import BaseModel
from typing import Optional, List
from typing import Dict, Any, Optional, List

class ChatHistoryInput(BaseModel):
    user_id: str
    message_text: str
    message_role: str

class HistoryResponse(BaseModel):
    message: str
    message_id: str

class HistoryAllResponse(BaseModel):
    results: List[Dict[str, Any]]

class HistoryResult(BaseModel):
    user_id: str
    message_text: str
    message_role: str

    def to_dict(self) -> Dict[str, Any]:
        """Convert to dictionary for JSON serialization"""
        return {
            "user_id": self.user_id,
            "message_text": self.message_text,
            "message_role": self.message_role,
        }

    @classmethod
    def from_db_row(cls, row: Dict[str, Any]) -> 'HistoryResult':
        """Create instance from database row"""
        return cls(
            user_id=row.get('user_id', ''),
            message_text=row.get('message_text', ''),
            message_role=row.get('message_role', '')
        )