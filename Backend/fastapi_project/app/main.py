from fastapi import FastAPI
from app.api.endpoints import user, task_folder, task

app = FastAPI()

# 엔드포인트 등록
app.include_router(user.router, prefix="/users", tags=["users"])
app.include_router(task_folder.router, prefix="/folders", tags=["folders"])
app.include_router(task.router, prefix="/tasks", tags=["tasks"])
