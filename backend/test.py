from fastapi import FastAPI, HTTPException
from pydantic import BaseModel, EmailStr
import pymysql
import bcrypt
from typing import Optional
app = FastAPI()

HOST = "localhost"
DB_USER = "root"
DB_PASSWORD = "root1234"
DATABASE = "hearsay_db"

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


@app.get("/")
async def root():
    return {"message": "Hello World"}


@app.post("/users", status_code=201)
async def createUser(data: UserCreate):
    try:
        connection = pymysql.connect(
            host=HOST,
            user=DB_USER,
            password=DB_PASSWORD,
            database=DATABASE,
            cursorclass=pymysql.cursors.DictCursor,
        )
        cursor = connection.cursor()

        hashed_password = bcrypt.hashpw(data.password.encode("utf-8"), bcrypt.gensalt())
        cursor.callproc("create_user", (data.email, data.username, hashed_password, data.firstName, data.lastName))
        connection.commit()
        return {"userCreated": True, "message": f"User {data.username} created successfully"}
    except pymysql.err.OperationalError as e:
        error_code, message = e.args
        raise HTTPException(status_code=400, detail=message)
    finally:
        connection.close()


@app.post("/users/login")
async def logInUser(data: UserLogin):
    try:
        connection = pymysql.connect(
            host=HOST,
            user=DB_USER,
            password=DB_PASSWORD,
            database=DATABASE,
            cursorclass=pymysql.cursors.DictCursor,
        )
        cursor = connection.cursor()
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
    finally:
        connection.close()


@app.get("/users/{user_id}")
async def getUser(user_id):
    try:
        connection = pymysql.connect(
            host=HOST,
            user=DB_USER,
            password=DB_PASSWORD,
            database=DATABASE,
            cursorclass=pymysql.cursors.DictCursor
        )

        cursor = connection.cursor()
        cursor.callproc("get_user", (user_id,))
        user_info = cursor.fetchone()
        if not user_info:
            raise HTTPException(status_code=404, detail=f"User not found")
        return {"user_info": user_info}
    finally:
        connection.close()


@app.put("/users/{user_id}")
async def updateBio(user_id: int, data: UserBio):
    try:
        connection = pymysql.connect(
            host=HOST,
            user=DB_USER,
            password=DB_PASSWORD,
            database=DATABASE,
            cursorclass=pymysql.cursors.DictCursor
        )

        cursor = connection.cursor()
        cursor.callproc("update_bio", (user_id, data.bio))
        connection.commit()
        return {"bioUpdated": True, "message": "User bio updated successfully", "bio": data.bio}
    except pymysql.err.OperationalError as e:
        error_code, message = e.args
        raise HTTPException(status_code=400, detail=message)
    finally:
        connection.close()


@app.get("/users/{user_id}/friends")
async def getUserFriends(user_id: int):
    try:
        connection = pymysql.connect(
            host=HOST,
            user=DB_USER,
            password=DB_PASSWORD,
            database=DATABASE,
            cursorclass=pymysql.cursors.DictCursor
        )
        cursor = connection.cursor()
        cursor.callproc("get_friends", (user_id,))
        user_friends = cursor.fetchall()
        return {"user_friends": user_friends}
    except pymysql.err.OperationalError as e:
        error_code, message = e.args
        raise HTTPException(status_code=400, detail=message)
    finally:
        connection.close()


@app.get("/podcasts")
async def searchPodcasts(
    name: Optional[str] = None,
    genre: Optional[str] = None,
    language: Optional[str] = None,
    platform: Optional[str] = None,
    host: Optional[str] = None,
    guest: Optional[str] = None,
    year: Optional[int] = None
):
    try:
        connection = pymysql.connect(
            host=HOST,
            user=DB_USER,
            password=DB_PASSWORD,
            database=DATABASE,
            cursorclass=pymysql.cursors.DictCursor
        )
        cursor = connection.cursor()
        cursor.callproc("search_podcasts", (name, genre, language, platform, host, guest, year))
        filtered_podcasts = cursor.fetchall()
        return {"podcasts": filtered_podcasts}
    except pymysql.err.OperationalError as e:
        error_code, message = e.args
        raise HTTPException(status_code=400, detail=message)
    finally:
        connection.close()