from fastapi import APIRouter
from typing import List
from domain.models import TaskFolderModel, TaskModel
from service.task_service import get_task_folders, get_tasks_in_folder, get_task_details

router = APIRouter()

@router.get("/folders", response_model=List[TaskFolderModel])
async def list_folders():
    return await get_task_folders()

@router.get("/folders/{folder_id}/tasks", response_model=List[TaskModel])
async def list_tasks_in_folder(folder_id: str):
    return await get_tasks_in_folder(folder_id)

@router.get("/tasks/{task_id}", response_model=TaskModel)
async def task_details(task_id: str):
    return await get_task_details(task_id)
