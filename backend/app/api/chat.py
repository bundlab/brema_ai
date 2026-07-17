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

    answer, provider = await router.chat(
        request.message
    )

    return ChatResponse(
        success=True,
        provider=provider,
        response=answer,
    )