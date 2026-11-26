
import httpx

from app.core.config import OLLAMA_URL, OLLAMA_MODEL


class OllamaService:

    async def generate(self, prompt: str) -> str:

        timeout = httpx.Timeout(
            connect=10.0,
            read=600.0,
            write=30.0,
            pool=10.0,
        )

        async with httpx.AsyncClient(
            timeout=timeout
        ) as client:

            response = await client.post(
                f"{OLLAMA_URL}/api/generate",
                json={
                    "model": OLLAMA_MODEL,
                    "prompt": prompt,
                    "stream": False,
                    "keep_alive": "10m",
                },
            )

            response.raise_for_status()

            data = response.json()

            return data["response"]


ollama = OllamaService()

