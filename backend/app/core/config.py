
import os

from dotenv import load_dotenv

load_dotenv()

HOST = os.getenv("HOST", "127.0.0.1")

PORT = int(os.getenv("PORT", "8010"))

DEFAULT_PROVIDER = os.getenv(
    "DEFAULT_PROVIDER",
    "ollama",
)

OLLAMA_URL = os.getenv(
    "OLLAMA_URL",
    "http://127.0.0.1:11434",
)

OLLAMA_MODEL = os.getenv(
    "OLLAMA_MODEL",
    "llama3.2:1b",
)

GEMINI_API_KEY = os.getenv(
    "GEMINI_API_KEY",
    "",
)

OPENAI_API_KEY = os.getenv(
    "OPENAI_API_KEY",
    "",
)

