
import httpx

from app.core.config import OLLAMA_URL, OLLAMA_MODEL


class OllamaService:

    async def generate(
        self,
        prompt: str,
        history: list[dict] | None = None,
    ) -> str:

        timeout = httpx.Timeout(
            connect=10.0,
            read=600.0,
            write=30.0,
            pool=10.0,
        )

        # Keep only the latest 20 previous messages.
        previous_messages = (history or [])[-20:]

        # Construct the complete conversation.
        messages = [
            *previous_messages,
            {
                "role": "user",
                "content": prompt,
            },
        ]

        async with httpx.AsyncClient(
            timeout=timeout
        ) as client:

            response = await client.post(
                f"{OLLAMA_URL}/api/chat",
                json={
                    "model": OLLAMA_MODEL,
                    "messages": messages,
                    "stream": False,
                    "keep_alive": "10m",
                },
            )

            response.raise_for_status()

            data = response.json()

            return data["message"]["content"]


ollama = OllamaService()

