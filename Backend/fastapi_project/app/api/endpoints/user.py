from fastapi import APIRouter, Depends, HTTPException
from sqlalchemy.orm import Session
from app.db import models, schemas, database

router = APIRouter()

@router.get("/", response_model=schemas.UserResponse)
def get_user(user_id: str, db: Session = Depends(database.SessionLocal)):
    user = db.query(models.User).filter(models.User.user_id == user_id).first()
    if not user:
        raise HTTPException(status_code=404, detail="User not found")
    return user
