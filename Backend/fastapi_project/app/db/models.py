from sqlalchemy import Column, String, Float, Integer, DateTime, ForeignKey
from sqlalchemy.orm import relationship
from app.db.database import Base
from datetime import datetime

class User(Base):
    __tablename__ = "users"
    user_id = Column(String, primary_key=True, index=True)
    name = Column(String, nullable=False)
    height = Column(Float, nullable=False)
    email = Column(String, unique=True, nullable=False)
    folders = relationship("TaskFolder", back_populates="user")

class TaskFolder(Base):
    __tablename__ = "task_folders"
    id = Column(String, primary_key=True, index=True)
    name = Column(String, nullable=False)
    user_id = Column(String, ForeignKey("users.user_id"), nullable=False)
    create_time = Column(DateTime, default=datetime.utcnow)
    tasks = relationship("Task", back_populates="folder")
    user = relationship("User", back_populates="folders")

class Task(Base):
    __tablename__ = "tasks"
    id = Column(String, primary_key=True, index=True)
    name = Column(String, nullable=False)
    point = Column(Integer, default=0)
    target_score = Column(Integer, nullable=False)
    folder_id = Column(String, ForeignKey("task_folders.id"), nullable=False)
    folder = relationship("TaskFolder", back_populates="tasks")
