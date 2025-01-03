from pydantic_settings import BaseSettings

class Settings(BaseSettings):
    MONGODB_URL: str = "mongodb://localhost:27017"
    DATABASE_NAME: str = "MVVM"

    class Config:
        env_file = ".env"

settings = Settings()
