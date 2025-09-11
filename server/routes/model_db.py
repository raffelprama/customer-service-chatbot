import logging

from fastapi import APIRouter,Depends
from typing import Optional,List
from dotenv import load_dotenv
from fastapi import FastAPI, Query, HTTPException, APIRouter

from server.schemas.model_db_schema import ModelResponse
from server.service.model_db_service import ModelService

logger = logging.getLogger(__name__)
load_dotenv()
model_router = APIRouter()

@model_router.get("/product", response_model=ModelResponse, tags=["Models"])
async def get_all_product():
    """
    get all product data
    """
    try:
        products = ModelService.get_all_product()
        
        return {
            "results": [item.to_dict() for item in products],
        }
        
    except Exception as e:
        logger.error(f"Error getting product: {e}")
        raise HTTPException(status_code=500, detail=str(e))

@model_router.get("/users", response_model=ModelResponse, tags=["Models"])
async def get_all_users():
    """
    get all users data
    """
    try:
        users = ModelService.get_all_user()
        
        return {
            "results": [item.to_dict() for item in users],
        }
        
    except Exception as e:
        logger.error(f"Error getting product: {e}")
        raise HTTPException(status_code=500, detail=str(e))
    
@model_router.get("/user", response_model=ModelResponse, tags=["Models"])
async def get_a_users(
    user_id: Optional[str] = Query(default=None, description="User id Input")
):
    """
    get a users data
    """
    try:
        users = ModelService.get_a_user(user_id)
        
        return {
            "results": [item.to_dict() for item in users],
        }
        
    except Exception as e:
        logger.error(f"Error getting product: {e}")
        raise HTTPException(status_code=500, detail=str(e))
    
@model_router.get("/garansi", response_model=ModelResponse, tags=["Models"])
async def get_all_garansi():
    """
    get all garansi data
    """
    try:
        garansi = ModelService.get_all_garansi()
        
        return {
            "results": [item.to_dict() for item in garansi],
        }
        
    except Exception as e:
        logger.error(f"Error getting product: {e}")
        raise HTTPException(status_code=500, detail=str(e))