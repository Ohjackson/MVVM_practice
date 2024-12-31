from fastapi import FastAPI
from controller.task_controller import router as task_router

app = FastAPI()

app.include_router(task_router, prefix="/api", tags=["Tasks"])

@app.get("/")
async def root():
    return {"message": "Welcome to the Task App API"}
