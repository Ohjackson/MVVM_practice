from fastapi import APIRouter, HTTPException, Depends
from app.db.database import db_instance
from app.db.models import User
from bson import ObjectId

router = APIRouter()

@router.post("/", response_model=User)
async def create_user(user: User):
    user_dict = user.dict(by_alias=True)
    result = await db_instance.db["users"].insert_one(user_dict)
    user_dict["_id"] = result.inserted_id
    return user_dict


@router.get("/{user_id}", response_model=User)
async def get_user(user_id: str):
    user = await db_instance.db["users"].find_one({"_id": ObjectId(user_id)})
    if not user:
        raise HTTPException(status_code=404, detail="User not found")
    return user
