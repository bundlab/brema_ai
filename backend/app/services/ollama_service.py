import httpx

from app.core.config import OLLAMA_URL


class OllamaService:

    async def generate(
        self,
        prompt: str,
    ) -> str:

        async with httpx.AsyncClient(
            timeout=120
        ) as client:

            response = await client.post(
                f"{OLLAMA_URL}/api/generate",
                json={
                    "model": "llama3",
                    "prompt": prompt,
                    "stream": False,
                },
            )

            response.raise_for_status()

            data = response.json()

            return data["response"]


ollama = OllamaService()
