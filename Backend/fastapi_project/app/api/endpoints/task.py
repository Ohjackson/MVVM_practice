
from fastapi import APIRouter, Depends, HTTPException
from sqlalchemy.orm import Session
from app.db import models, schemas, database

router = APIRouter()

@router.get("/{task_id}", response_model=schemas.TaskResponse)
def get_task(task_id: str, db: Session = Depends(database.SessionLocal)):
    task = db.query(models.Task).filter(models.Task.id == task_id).first()
    if not task:
        raise HTTPException(status_code=404, detail="Task not found")
    return task
