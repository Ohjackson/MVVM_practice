from pydantic import BaseModel
from datetime import datetime
from typing import List, Optional

class UserBase(BaseModel):
    user_id: str
    name: str
    height: float
    email: str

class TaskFolderBase(BaseModel):
    id: str
    name: str
    user_id: str
    create_time: datetime

class TaskBase(BaseModel):
    id: str
    name: str
    point: int
    target_score: int

class UserResponse(UserBase):
    folders: Optional[List[TaskFolderBase]] = []

class TaskFolderResponse(TaskFolderBase):
    tasks: Optional[List[TaskBase]] = []

class TaskResponse(TaskBase):
    pass

    class Config:
        orm_mode = True
