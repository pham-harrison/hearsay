import pymysql
from contextlib import contextmanager
from dotenv import load_dotenv
import os

load_dotenv()

HOST = os.getenv("HOST")
DB_USER = os.getenv("DB_USER")
DB_PASSWORD = os.getenv("DB_PASSWORD")
DATABASE = os.getenv("DATABASE")


@contextmanager
def db_cursor():
    connection = pymysql.connect(
        host=HOST,
        user=DB_USER,
        password=DB_PASSWORD,
        database=DATABASE,
        cursorclass=pymysql.cursors.DictCursor,
    )
    cursor = connection.cursor()
    try:
        yield cursor
        connection.commit()
    finally:
        connection.close()
