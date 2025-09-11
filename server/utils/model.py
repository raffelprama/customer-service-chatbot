from server.service.model_db_service import ModelService
from server.service.history_db_service import HistoryService

def fetch_products():
    products = ModelService.get_all_product()
    return {
        "results": [product.to_dict() for product in products],
    }
def recent_chat(user_id):
    historys = HistoryService.fetch_last_messages(user_id, count=5) 
    # print(historys)
    return {
        "results": [historys],
    }
