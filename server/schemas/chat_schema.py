from pydantic import BaseModel
from datetime import datetime
from typing import Dict, Any, Optional, List


class Item(BaseModel):
    input: Optional[str] = None

class ChatResponse(BaseModel):
    id: str
    output:str
    createAt:datetime