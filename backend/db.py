import pymysql
from contextlib import contextmanager

HOST = "localhost"
DB_USER = "root"
DB_PASSWORD = "root1234"
DATABASE = "hearsay_db"

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