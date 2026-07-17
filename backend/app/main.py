from fastapi import FastAPI
from fastapi.middleware.cors import CORSMiddleware
from app.api.chat import router_api
from app.api.health import router as health_router
from app.middleware.exception_handler import (
    global_exception_handler,
)

app = FastAPI(
    title="BremaAI Backend",
    version="1.0.0",
)

app.add_exception_handler(
    Exception,
    global_exception_handler,
)

app.add_middleware(
    CORSMiddleware,
    allow_origins=["*"],
    allow_credentials=True,
    allow_methods=["*"],
    allow_headers=["*"],
)

app.include_router(
    health_router,
    prefix="/api/v1",
    tags=["Health"],
)

app.include_router(
    router_api,
    prefix="/api/v1",
    tags=["Chat"],
)


@app.get("/")
async def root():

    return {
        "message": "BremaAI Backend Running"
    }
