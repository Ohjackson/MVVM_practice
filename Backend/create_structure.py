import os

# 프로젝트 디렉토리 및 파일 구조 정의
project_structure = {
    "app": [
        "__init__.py",
        "main.py",
        "core/__init__.py",
        "core/config.py",
        "core/security.py",
        "db/__init__.py",
        "db/database.py",
        "db/models.py",
        "db/schemas.py",
        "api/__init__.py",
        "api/deps.py",
        "api/endpoints/__init__.py",
        "api/endpoints/user.py",
        "api/endpoints/auth.py",
        "api/endpoints/item.py",
        "tests/__init__.py",
        "tests/test_main.py",
    ],
    ".": [".env", "requirements.txt", "README.md"],
}

# 파일 내용 템플릿
file_templates = {
    "README.md": "# FastAPI Project\n\nThis is a FastAPI project structure.",
    "requirements.txt": "fastapi\nuvicorn\npydantic\nsqlalchemy",
    ".env": "# Add your environment variables here\nDATABASE_URL=sqlite:///./test.db\nSECRET_KEY=your-secret-key",
    "app/main.py": """from fastapi import FastAPI\n\napp = FastAPI()\n\n@app.get("/")\ndef read_root():\n    return {"message": "Hello, FastAPI!"}\n""",
}

def create_project_structure(base_path, structure):
    for folder, files in structure.items():
        folder_path = os.path.join(base_path, folder)
        if folder != ".":
            os.makedirs(folder_path, exist_ok=True)  # 디렉토리 생성
        for file_name in files:
            file_path = os.path.join(folder_path, file_name) if folder != "." else os.path.join(base_path, file_name)
            # 상위 디렉토리가 없을 경우 디렉토리를 생성
            os.makedirs(os.path.dirname(file_path), exist_ok=True)
            with open(file_path, "w") as f:
                # 파일 내용 템플릿이 있으면 추가, 없으면 빈 파일 생성
                content = file_templates.get(f"{folder}/{file_name}", "")
                f.write(content)

# 프로젝트 생성 실행
if __name__ == "__main__":
    base_path = "fastapi_project"
    os.makedirs(base_path, exist_ok=True)  # 프로젝트 루트 디렉토리 생성
    create_project_structure(base_path, project_structure)
    print(f"FastAPI project structure created at '{base_path}'!")
