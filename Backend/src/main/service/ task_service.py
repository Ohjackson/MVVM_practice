from typing import List
from domain.models import TaskFolderModel, TaskModel

# Mock 데이터
folders = [
    TaskFolderModel(id="1", name="Folder 1", user_id="user123", create_time="2024-12-30"),
    TaskFolderModel(id="2", name="Folder 2", user_id="user123", create_time="2024-12-30"),
]

tasks = [
    TaskModel(id="101", name="Task 1", point=10, target_score=20),
    TaskModel(id="102", name="Task 2", point=15, target_score=25),
]

async def get_task_folders() -> List[TaskFolderModel]:
    return folders

async def get_tasks_in_folder(folder_id: str) -> List[TaskModel]:
    return tasks  # 필터링 로직 추가 가능

async def get_task_details(task_id: str) -> TaskModel:
    for task in tasks:
        if task.id == task_id:
            return task
    return None
