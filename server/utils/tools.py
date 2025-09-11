from server.service.model_db_service import ModelService
from server.service.history_db_service import HistoryService

# === Define Tools ===
def fetch_user(user_id: str):
    user = ModelService.get_a_user(user_id)
    return {
        "results": [u.to_dict() for u in user],
    }

def fetch_garansi():
    garansi = ModelService.get_all_garansi()
    return {
        "results": [g.to_dict() for g in garansi]
    }

tools = {
    "get_user": fetch_user,
    "get_garansi": fetch_garansi,
}