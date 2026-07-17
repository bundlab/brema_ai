class GeminiService:

    async def generate(
        self,
        prompt: str,
    ) -> str:

        return (
            "Gemini provider is not enabled yet."
        )


gemini = GeminiService()
