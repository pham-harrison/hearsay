from fastapi import FastAPI

from backend.routers.users import router as users_router
from backend.routers.podcasts import router as podcasts_router
app = FastAPI()

app.include_router(users_router)
app.include_router(podcasts_router)

@app.get("/")
async def root():
    return {"message": "Hello World"}
