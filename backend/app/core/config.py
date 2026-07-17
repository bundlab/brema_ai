import os

from dotenv import load_dotenv

load_dotenv()

HOST = os.getenv("HOST", "127.0.0.1")
PORT = int(os.getenv("PORT", "8000"))

DEFAULT_PROVIDER = os.getenv(
    "DEFAULT_PROVIDER",
    "ollama",
)

OLLAMA_URL = os.getenv(
    "OLLAMA_URL",
    "http://localhost:11434",
)

GEMINI_API_KEY = os.getenv(
    "GEMINI_API_KEY",
    "",
)

OPENAI_API_KEY = os.getenv(
    "OPENAI_API_KEY",
    "",
)