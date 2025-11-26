import pymysql
from fastapi import APIRouter, HTTPException, Depends
from pydantic import BaseModel, EmailStr

from ..db import db_cursor
from .auth import getCurrentUser
from .playlists import router as playlist_router

router = APIRouter(prefix="/users")
router.include_router(playlist_router, prefix="/{user_id}/playlists")

class UserPublic(BaseModel):
    id: int
    email: EmailStr
    username: str
    firstName: str
    lastName: str

class UserBio(BaseModel):
    bio: str

# Get all users
@router.get("/all")
async def getAllUsers():
    try:
        with db_cursor() as cursor:
            cursor.execute("SELECT id, username, first_name, last_name, bio FROM user")
            users = cursor.fetchall()
            return users
    except pymysql.err.OperationalError as e:
        error_code, message = e.args
        raise HTTPException(status_code=400, detail=message)


# Get all user details by ID
@router.get("/{user_id}")
async def getUser(user_id: int):
    try:
        with db_cursor() as cursor:
            cursor.callproc("get_user_by_id", (user_id,))
            user_info = cursor.fetchone()
            return user_info
    except pymysql.err.OperationalError as e:
        error_code, message = e.args
        raise HTTPException(status_code=400, detail=message)


# Get user by username
@router.get("/username/{user_name}")
async def getUserByUsername(user_name: str):
    try:
        with db_cursor() as cursor:
            cursor.callproc("get_user_by_username", (user_name,))
            user_info = cursor.fetchall()
            return user_info
    except pymysql.err.OperationalError as e:
        error_code, message = e.args
        raise HTTPException(status_code=400, detail=message)


# Update user bio
@router.put("/{user_id}")
async def updateBio(
    user_id: int, data: UserBio, current_user: int = Depends(getCurrentUser)
):
    if current_user != user_id:
        raise HTTPException(
            status_code=400, detail="Unauthorized to make changes to user"
        )
    try:
        with db_cursor() as cursor:
            cursor.callproc("update_bio", (user_id, data.bio))
            return {
                "bioUpdated": True,
                "message": "User bio updated successfully",
                "bio": data.bio,
            }
    except pymysql.err.OperationalError as e:
        error_code, message = e.args
        raise HTTPException(status_code=400, detail=message)


# Get all friends for a user
@router.get("/{user_id}/friends")
async def getUserFriends(user_id: int):
    try:
        with db_cursor() as cursor:
            cursor.callproc("get_friends", (user_id,))
            user_friends = cursor.fetchall()
            return user_friends
    except pymysql.err.OperationalError as e:
        error_code, message = e.args
        raise HTTPException(status_code=400, detail=message)


# Delete a user's friends
@router.delete("/{user_id}/friends/{user_to_delete_id}")
async def deleteFriend(
    user_id: int, user_to_delete_id: int, current_user: int = Depends(getCurrentUser)
):
    if current_user != user_id:
        raise HTTPException(
            status_code=400, detail="Unauthorized to make changes to user"
        )
    try:
        with db_cursor() as cursor:
            cursor.callproc("delete_friend", (user_id, user_to_delete_id))
            return {"friendDeleted": True}
    except pymysql.err.OperationalError as e:
        error_code, message = e.args
        raise HTTPException(status_code=400, detail=message)

# Get a user's feed (all reviews from the friends of a user)
@router.get("/{user_id}/feed")
async def getUserFeed(user_id: int):
    try:
        with db_cursor() as cursor:
            cursor.callproc("get_user_friends_reviews", (user_id,))
            return cursor.fetchall()
    except pymysql.err.OperationalError as e:
        error_code, message = e.args
        raise HTTPException(status_code=400, detail=message)
    
# Get a user's latest podcast reviews
@router.get("/{user_id}/reviews/podcasts")
async def getUserReviews(user_id: int):
    try:
        with db_cursor() as cursor:
            cursor.callproc("get_user_podcast_reviews", (user_id,))
            return cursor.fetchall()
    except pymysql.err.OperationalError as e:
        error_code, message = e.args
        raise HTTPException(status_code=400, detail=message)
    
# Get a user's latest episode reviews
@router.get("/{user_id}/reviews/episodes")
async def getUserReviews(user_id: int):
    try:
        with db_cursor() as cursor:
            cursor.callproc("get_user_episode_reviews", (user_id,))
            return cursor.fetchall()
    except pymysql.err.OperationalError as e:
        error_code, message = e.args
        raise HTTPException(status_code=400, detail=message)