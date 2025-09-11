import uuid

from pydantic import BaseModel, ConfigDict
from typing import Dict, Any, Optional, List

class ModelResponse(BaseModel):
    results: List[Dict[str, Any]]

class ProductResult:
    def __init__(
        self,
        id: uuid.UUID,
        product: str,
        quantity: int,
        positive: str,
        negative: str,
        price: int,
    ):
        self.id = id
        self.product = product
        self.quantity = quantity
        self.positive = positive
        self.negative = negative
        self.price = price

    def to_dict(self) -> Dict[str, Any]:
        """Convert to dictionary for JSON serialization"""
        return {
            "id": str(self.id), 
            "product": self.product,
            "quantity": self.quantity,
            "positive": self.positive,
            "negative": self.negative,
            "price": self.price,
        }

    @classmethod
    def from_db_row(cls, row: Dict[str, Any]) -> 'ProductResult':
        """Create instance from database row"""
        return cls(
            id=row['id'],
            product=row['product'],
            quantity=row['quantity'],
            positive=row['positive'],
            negative=row['negative'],
            price=row['price']
        )
    

class UserResult:
    def __init__(
        self,
        id_data: str,
        user_id: uuid.UUID,
        product: str,
        status: str,
        estimasi: str
    ):
        self.id_data = id_data
        self.user_id = user_id
        self.product = product
        self.status = status
        self.estimasi = estimasi

    def to_dict(self) -> Dict[str, Any]:
        """Convert to dictionary for JSON serialization"""
        return {
            "id_data": str(self.id_data), 
            "user_id": self.user_id,
            "product": self.product,
            "status": self.status,
            "estimasi": self.estimasi,
        }

    @classmethod
    def from_db_row(cls, row: Dict[str, Any]) -> 'UserResult':
        """Create instance from database row"""
        return cls(
            id_data=row['id_data'],
            user_id=row['user_id'],
            product=row['product'],
            status=row['status'],
            estimasi=row['estimasi'],
        )

class GaransiResult:
    def __init__(
        self,
        garansi_id: uuid.UUID,
        garansi_description: str
    ):
        self.garansi_id = garansi_id
        self.garansi_description = garansi_description

    def to_dict(self) -> Dict[str, Any]:
        """Convert to dictionary for JSON serialization"""
        return {
            "garansi_id": str(self.garansi_id), 
            "garansi_description": self.garansi_description
        }

    @classmethod
    def from_db_row(cls, row: Dict[str, Any]) -> 'GaransiResult':
        """Create instance from database row"""
        return cls(
            garansi_id=row['garansi_id'],
            garansi_description=row['garansi_description']
        )