
from fastapi import APIRouter

from app.schemas.chat import (
    ChatRequest,
    ChatResponse,
)

from app.services.ai_router import (
    router,
)

router_api = APIRouter()


@router_api.post(
    "/chat",
    response_model=ChatResponse,
)
async def chat(
    request: ChatRequest,
):
    history = [
        message.model_dump()
        for message in request.history
    ]

    answer, provider = await router.chat(
        request.message,
        history,
    )

    return ChatResponse(
        success=True,
        provider=provider,
        response=answer,
    )

