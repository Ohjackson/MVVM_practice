from datetime import datetime
from pydantic import BaseModel

class TaskFolderModel(BaseModel):
    id: str
    name: str
    user_id: str
    create_time: datetime

class TaskModel(BaseModel):
    id: str
    name: str
    point: int
    target_score: int

class UserModel(BaseModel):
    user_id: str
    name: str
    height: float
    email: str
