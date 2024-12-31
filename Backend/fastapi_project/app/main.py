from fastapi import FastAPI
from app.db.database import connect_to_mongo, close_mongo_connection
from app.api.endpoints import task_folder

app = FastAPI()

@app.on_event("startup")
async def startup_event():
    await connect_to_mongo()

@app.on_event("shutdown")
async def shutdown_event():
    await close_mongo_connection()

app.include_router(task_folder.router, prefix="/folders", tags=["folders"])