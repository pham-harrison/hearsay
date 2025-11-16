from fastapi import FastAPI, HTTPException
from pydantic import BaseModel, EmailStr
import pymysql
import bcrypt

app = FastAPI()

HOST = "localhost"
DB_USER = "root"
DB_PASSWORD = "root1234"
DATABASE = "hearsay_db"

class UserCreate(BaseModel):
    email: EmailStr
    username: str
    password: str
    first_name: str
    last_name: str

class UserLogin(BaseModel):
    username: str
    password: str

class UserBio(BaseModel):
    bio: str

@app.get("/")
async def root():
    return {"message": "Hello World"}

@app.post("/users", status_code=201)
async def createUser(data: UserCreate): # Check if email is already registered
    try:
        connection = pymysql.connect(
            host=HOST,
            user=DB_USER,
            password=DB_PASSWORD,
            database=DATABASE,
            cursorclass=pymysql.cursors.DictCursor,
        )
        cursor = connection.cursor()

        cursor.execute("SELECT id FROM user WHERE email=%s", (data.email,))
        if cursor.fetchone():
            raise HTTPException(status_code=400, detail=f"Email {data.email} is already registered")

        cursor.execute("SELECT id FROM user WHERE username=%s", (data.username,))
        if cursor.fetchone():
            raise HTTPException(status_code=400, detail=f"Username {data.username} is already taken")

        hashed_password = bcrypt.hashpw(data.password.encode("utf-8"), bcrypt.gensalt())
        cursor.callproc("create_user", (data.email, data.username, hashed_password, data.first_name, data.last_name))
        connection.commit()
        return {"message": f"User {data.username} created successfully"}
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
        cursor.execute("SELECT * FROM user WHERE username=%s", (data.username,))
        user_info = cursor.fetchone()

        if not user_info:
            raise HTTPException(status_code=404, detail=f"User not found")
        
        password = data.password.encode("utf-8")
        stored_password = user_info["password_hash"].encode("utf-8")

        if bcrypt.checkpw(password, stored_password):
            return {"user_id": user_info["id"], "logged_in": True}
        else:
            raise HTTPException(status_code=401, detail="Incorrect password")
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
        return user_info
    finally:
        connection.close()


@app.put("/users/{user_id}")
async def updateBio(user_id: int):
    try:
        connection = pymysql.connect(
            host=HOST,
            user=DB_USER,
            password=DB_PASSWORD,
            database=DATABASE,
            cursorclass=pymysql.cursors.DictCursor
        )

        cursor = connection.cursor()
        
    finally:
        connection.close()