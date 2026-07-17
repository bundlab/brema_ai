import asyncio
from datetime import datetime


class MockService:

    async def generate(self, prompt: str) -> str:
        await asyncio.sleep(1)

        return f"""
# Brema AI

Hello 👋

I'm currently running in **Mock Mode**.

Current Time:
{datetime.now()}

---

You asked:

> {prompt}

---

Everything is working correctly:

✅ Flutter

✅ FastAPI

✅ AI Router

✅ JSON API

Next we'll connect a real AI model.
"""


mock = MockService()