import jwt
import os
import bcrypt
import pymysql

from datetime import datetime, timedelta
from fastapi.security import OAuth2PasswordBearer
from typing import Optional
from fastapi import APIRouter, HTTPException, Depends
from pydantic import BaseModel, EmailStr
from dotenv import load_dotenv
from ..db import db_cursor

load_dotenv()
router = APIRouter(prefix="/users")

JWT_SECRET = os.getenv("JWT_SECRET")
JWT_ALGORITHM = os.getenv("JWT_ALGORITHM")
JWT_EXPIRE_MINUTES = int(os.getenv("JWT_EXPIRE_MINUTES"))

oauth2_scheme = OAuth2PasswordBearer(tokenUrl="/users/login")

class Token(BaseModel):
    access_token: str
    token_type: str = "bearer"

class UserCreate(BaseModel):
    email: EmailStr
    username: str
    password: str
    firstName: str
    lastName: str

class UserLogin(BaseModel):
    username: str
    password: str

# Create user account
@router.post("/register")
async def createUser(data: UserCreate):
    try:
        with db_cursor() as cursor:
            hashed_password = bcrypt.hashpw(
                data.password.encode("utf-8"), bcrypt.gensalt()
            )
            cursor.callproc(
                "create_user",
                (
                    data.email,
                    data.username,
                    hashed_password,
                    data.firstName,
                    data.lastName,
                ),
            )
            return {
                "userCreated": True,
                "message": f"User {data.username} created successfully",
            }
    except pymysql.err.OperationalError as e:
        error_code, message = e.args
        print("Operation error: ", error_code, message)
        raise HTTPException(status_code=400, detail=message)


# Login a registered user
@router.post("/login", response_model=Token)
async def logInUser(data: UserLogin):
    try:
        with db_cursor() as cursor:
            cursor.callproc("get_user_log_in_details", (data.username,))
            db_user = cursor.fetchone()
            if not db_user:
                raise HTTPException(
                    status_code=400, detail="Invalid username and/or password"
                )
            if not verify_password(data.password, db_user["password_hash"]):
                raise HTTPException(
                    status_code=400, detail="Invalid username and/or password"
                )
            access_token = create_access_token(data={"sub": str(db_user["id"])})
            return Token(access_token=access_token)
    except pymysql.err.OperationalError as e:
        error_code, message = e.args
        raise HTTPException(status_code=400, detail=message)


# Get current user
async def getCurrentUser(token: str = Depends(oauth2_scheme)):
    payload = decode_access_token(token)
    user_id: int = int(payload.get("sub"))
    if user_id is None:
        raise HTTPException(
            status_code=400,
            detail="Token payload missing subject",
        )
    try:
        with db_cursor() as cursor:
            stmt = "CALL get_user_by_id(%s)"
            cursor.execute(stmt, (user_id,))
    except pymysql.MySQLError as e:
        error_code, message = e.args
        raise HTTPException(status_code=400, detail=message)
    return user_id

# Password helper functions
def hash_password(plain_password: str) -> str:
    salt = bcrypt.gensalt()
    hashed = bcrypt.hashpw(plain_password.encode("utf-8"), salt)
    return hashed.decode("utf-8")


def verify_password(plain_password: str, hashed_password: str) -> bool:
    return bcrypt.checkpw(
        plain_password.encode("utf-8"), hashed_password.encode("utf-8")
    )

# JWT helper functions
def create_access_token(data: dict, expires_delta: Optional[timedelta] = None) -> str:
    to_encode = data.copy()
    expire = datetime.utcnow() + (
        expires_delta or timedelta(minutes=JWT_EXPIRE_MINUTES)
    )
    to_encode.update({"exp": expire})
    encoded_jwt = jwt.encode(to_encode, JWT_SECRET, algorithm=JWT_ALGORITHM)
    return encoded_jwt


def decode_access_token(token: str) -> dict:
    try:
        payload = jwt.decode(token, JWT_SECRET, algorithms=[JWT_ALGORITHM])
        return payload
    except jwt.ExpiredSignatureError:
        raise HTTPException(status_code=400, detail="Token expired")
    except jwt.InvalidTokenError:
        raise HTTPException(status_code=400, detail="Invalid token")