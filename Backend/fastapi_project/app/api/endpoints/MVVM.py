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


from fastapi import APIRouter, HTTPException, status
from bson import ObjectId
from app.db.database import db_instance
from app.db.models import TaskFolder

router = APIRouter()

# Create a new TaskFolder
@router.post("/", response_model=TaskFolder, status_code=status.HTTP_201_CREATED)
async def create_task_folder(folder: TaskFolder):
    folder_dict = folder.dict(by_alias=True)
    result = await db_instance.db["task_folders"].insert_one(folder_dict)
    folder_dict["_id"] = result.inserted_id
    return folder_dict


# Get a TaskFolder by ID
@router.get("/{folder_id}", response_model=TaskFolder)
async def get_task_folder(folder_id: str):
    if not ObjectId.is_valid(folder_id):
        raise HTTPException(status_code=status.HTTP_400_BAD_REQUEST, detail="Invalid ObjectId")
    
    folder = await db_instance.db["task_folders"].find_one({"_id": ObjectId(folder_id)})
    if not folder:
        raise HTTPException(status_code=status.HTTP_404_NOT_FOUND, detail="Folder not found")
    return folder


# Get all TaskFolders
@router.get("/", response_model=list[TaskFolder])
async def get_all_task_folders():
    folders = await db_instance.db["task_folders"].find().to_list(100)
    return folders


# Update a TaskFolder
@router.put("/{folder_id}", response_model=TaskFolder)
async def update_task_folder(folder_id: str, updated_data: TaskFolder):
    if not ObjectId.is_valid(folder_id):
        raise HTTPException(status_code=status.HTTP_400_BAD_REQUEST, detail="Invalid ObjectId")
    
    update_result = await db_instance.db["task_folders"].update_one(
        {"_id": ObjectId(folder_id)}, {"$set": updated_data.dict(by_alias=True)}
    )
    
    if update_result.matched_count == 0:
        raise HTTPException(status_code=status.HTTP_404_NOT_FOUND, detail="Folder not found")
    
    updated_folder = await db_instance.db["task_folders"].find_one({"_id": ObjectId(folder_id)})
    return updated_folder


# Delete a TaskFolder
@router.delete("/{folder_id}", status_code=status.HTTP_204_NO_CONTENT)
async def delete_task_folder(folder_id: str):
    if not ObjectId.is_valid(folder_id):
        raise HTTPException(status_code=status.HTTP_400_BAD_REQUEST, detail="Invalid ObjectId")
    
    delete_result = await db_instance.db["task_folders"].delete_one({"_id": ObjectId(folder_id)})
    
    if delete_result.deleted_count == 0:
        raise HTTPException(status_code=status.HTTP_404_NOT_FOUND, detail="Folder not found")
    
    return {"message": "TaskFolder deleted successfully"}
