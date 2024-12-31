from fastapi import APIRouter, HTTPException
from app.db.database import db_instance

router = APIRouter()

@router.post("/insert")
async def insert_data(name: str):
    """
    MVVM 데이터베이스에 데이터 삽입.
    """
    result = await db_instance.db["test_collection"].insert_one({"name": name})
    return {"inserted_id": str(result.inserted_id)}

@router.get("/data")
async def get_data():
    """
    MVVM 데이터베이스의 모든 데이터 조회.
    """
    data = await db_instance.db["test_collection"].find().to_list(100)
    return data
