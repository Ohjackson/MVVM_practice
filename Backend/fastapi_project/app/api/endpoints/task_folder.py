from fastapi import APIRouter, HTTPException
from app.db.database import db_instance
from app.db.models import TaskFolder
from bson import ObjectId

router = APIRouter()

@router.get("/{folder_id}", response_model=TaskFolder)
async def get_task_folder(folder_id: str):
    folder = await db_instance.db["task_folders"].find_one({"_id": ObjectId(folder_id)})
    if not folder:
        raise HTTPException(status_code=404, detail="Folder not found")
    return folder

@router.post("/", response_model=TaskFolder)
async def create_task_folder(folder: TaskFolder):
    folder_dict = folder.dict(by_alias=True)
    result = await db_instance.db["task_folders"].insert_one(folder_dict)
    folder_dict["_id"] = result.inserted_id
    return folder_dict
