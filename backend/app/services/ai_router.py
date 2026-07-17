from app.core.config import DEFAULT_PROVIDER

from app.services.mock_service import mock
from app.services.ollama_service import ollama
from app.services.gemini_service import gemini


class AIRouter:

    async def chat(self, prompt: str):

        if DEFAULT_PROVIDER == "mock":
            answer = await mock.generate(prompt)
            return answer, "mock"

        elif DEFAULT_PROVIDER == "ollama":
            answer = await ollama.generate(prompt)
            return answer, "ollama"

        elif DEFAULT_PROVIDER == "gemini":
            answer = await gemini.generate(prompt)
            return answer, "gemini"

        raise Exception(
            f"Unknown provider: {DEFAULT_PROVIDER}"
        )


router = AIRouter()