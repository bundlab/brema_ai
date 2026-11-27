
from pydantic import BaseModel, Field
from typing import Literal


class ChatHistoryMessage(BaseModel):
    role: Literal["user", "assistant"]
    content: str


class ChatRequest(BaseModel):
    message: str

    history: list[ChatHistoryMessage] = Field(
        default_factory=list
    )


class ChatResponse(BaseModel):
    success: bool
    provider: str
    response: str

