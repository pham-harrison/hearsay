from fastapi import APIRouter, HTTPException
from pydantic import BaseModel, EmailStr
from ..db import db_cursor
from .playlists import router as playlist_router
import pymysql
import bcrypt

router = APIRouter(prefix="/users")
router.include_router(playlist_router, prefix="/{user_id}/playlists")

class UserCreate(BaseModel):
    email: EmailStr
    username: str
    password: str
    firstName: str
    lastName: str

class UserLogin(BaseModel):
    username: str
    password: str

class UserBio(BaseModel):
    bio: str

# Create user account
@router.post("/", status_code=201)
async def createUser(data: UserCreate):
    try:
        with db_cursor() as cursor:
            hashed_password = bcrypt.hashpw(data.password.encode("utf-8"), bcrypt.gensalt())
            cursor.callproc("create_user", (data.email, data.username, hashed_password, data.firstName, data.lastName))
            return {"userCreated": True, "message": f"User {data.username} created successfully"}
    except pymysql.err.OperationalError as e:
        error_code, message = e.args
        raise HTTPException(status_code=400, detail=message)

# Login a registered user
@router.post("/login")
async def logInUser(data: UserLogin):
    try:
        with db_cursor() as cursor:
            cursor.callproc("get_user_log_in_details", (data.username,))
            user_info = cursor.fetchone()
            
            password = data.password.encode("utf-8")
            stored_password = user_info["password_hash"].encode("utf-8")

            if bcrypt.checkpw(password, stored_password):
                return {"user_id": user_info["id"], "logged_in": True}
            else:
                raise HTTPException(status_code=400, detail="Invalid username and/or password")
    except pymysql.err.OperationalError as e:
        error_code, message = e.args
        raise HTTPException(status_code=400, detail=message)

# Get all user details
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
async def updateBio(user_id: int, data: UserBio):
    try:
        with db_cursor() as cursor:
            cursor.callproc("update_bio", (user_id, data.bio))
            return {"bioUpdated": True, "message": "User bio updated successfully", "bio": data.bio}
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
async def deleteFriend(user_id: int, user_to_delete_id: int):
    try:
        with db_cursor() as cursor:
            cursor.callproc("delete_friend", (user_id, user_to_delete_id))
            return {"friendDeleted": True}
    except pymysql.err.OperationalError as e:
        error_code, message = e.args
        raise HTTPException(status_code=400, detail=message)