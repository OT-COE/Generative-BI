import os
import json
from dotenv import load_dotenv
from pydantic_settings import BaseSettings
from typing import Optional, Dict

load_dotenv()

class Settings(BaseSettings):
    # Groq Configuration
    groq_api_key: str = os.getenv("GROQ_API_KEY", "")
    
    # Database Configurations
    postgres_host: str = os.getenv("POSTGRES_HOST", "localhost")
    postgres_port: int = int(os.getenv("POSTGRES_PORT", "5432"))
    postgres_db: str = os.getenv("POSTGRES_DB", "")
    postgres_user: str = os.getenv("POSTGRES_USER", "")
    postgres_password: str = os.getenv("POSTGRES_PASSWORD", "")
    
    mysql_host: str = os.getenv("MYSQL_HOST", "localhost")
    mysql_port: int = int(os.getenv("MYSQL_PORT", "3306"))
    mysql_db: str = os.getenv("MYSQL_DB", "")
    mysql_user: str = os.getenv("MYSQL_USER", "")
    mysql_password: str = os.getenv("MYSQL_PASSWORD", "")
    
    oracle_host: str = os.getenv("ORACLE_HOST", "localhost")
    oracle_port: int = int(os.getenv("ORACLE_PORT", "1521"))
    oracle_service: str = os.getenv("ORACLE_SERVICE", "")
    oracle_user: str = os.getenv("ORACLE_USER", "")
    oracle_password: str = os.getenv("ORACLE_PASSWORD", "")
    
    # Vector Database
    chroma_persist_directory: str = os.getenv("CHROMA_PERSIST_DIRECTORY", "./chroma_db")
    
    # Application Settings
    max_query_results: int = 10000
    embedding_model: str = "all-MiniLM-L6-v2"
    chat_model: str = "openai/gpt-oss-120b"
    
    
    def get_predefined_databases(self) -> Dict[str, str]:
        """Parse predefined databases from environment variable"""
        predefined_db_json = os.getenv("PREDEFINED_DATABASES", "{}")
        try:
            return json.loads(predefined_db_json)
        except json.JSONDecodeError:
            return {}
    
    @property
    def predefined_databases(self) -> Dict[str, str]:
        return self.get_predefined_databases()
    
    class Config:
        env_file = ".env"
        extra = "allow"

settings = Settings()
