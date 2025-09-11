import logging

from server.schemas.model_db_schema import ProductResult, UserResult, GaransiResult
from server.database.db import get_db_connection

logger = logging.getLogger(__name__)

class ModelService:
    id: str
    product: str
    quantity: int
    positive: str
    negative: str
    price: int

    @staticmethod
    def get_all_product():
        """Get all product results with pagination"""
        try:
            # Get paginated results
            select_query = """
            SELECT * FROM product
            ORDER BY id ASC
            """
            
            with get_db_connection() as conn:
                with conn.cursor() as cursor:
                    # Get paginated results
                    cursor.execute(select_query)
                    rows = cursor.fetchall()
                    
                    products = [ProductResult.from_db_row(row) for row in rows]
                    return products
                    
        except Exception as e:
            logger.error(f"Error getting all benchmarks: {e}")
            raise

    @staticmethod
    def get_all_user():
        """Get all users results with pagination"""
        try:
            # Get paginated results
            select_query = """
            SELECT * FROM users
            ORDER BY user_id ASC
            """
            
            with get_db_connection() as conn:
                with conn.cursor() as cursor:
                    # Get paginated results
                    cursor.execute(select_query)
                    rows = cursor.fetchall()
                    
                    products = [UserResult.from_db_row(row) for row in rows]
                    return products
                    
        except Exception as e:
            logger.error(f"Error getting all benchmarks: {e}")
            raise

    @staticmethod
    def get_a_user(user_id:str):
        """Get a users results with pagination"""
        try:
            # Get paginated results
            select_query = """
            SELECT * FROM users
            WHERE user_id::text = %s
            ORDER BY user_id DESC
            """
            
            with get_db_connection() as conn:
                with conn.cursor() as cursor:
                    # Get paginated results
                    cursor.execute(select_query, (user_id,))
                    rows = cursor.fetchall()
                    
                    users = [UserResult.from_db_row(row) for row in rows]
                    return users
                    
        except Exception as e:
            logger.error(f"Error getting all benchmarks: {e}")
            raise

    @staticmethod
    def get_all_garansi():
        """Get all garansi results with pagination"""
        try:
            # Get paginated results
            select_query = """
            SELECT * FROM garansi
            ORDER BY garansi_id ASC
            """
            
            with get_db_connection() as conn:
                with conn.cursor() as cursor:
                    # Get paginated results
                    cursor.execute(select_query)
                    rows = cursor.fetchall()
                    
                    garansi = [GaransiResult.from_db_row(row) for row in rows]
                    return garansi
                    
        except Exception as e:
            logger.error(f"Error getting all benchmarks: {e}")
            raise