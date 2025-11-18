from fastapi import FastAPI, HTTPException
from pydantic import BaseModel, EmailStr
from contextlib import contextmanager

import pymysql
import bcrypt
from typing import Optional
app = FastAPI()

HOST = "localhost"
DB_USER = "root"
DB_PASSWORD = "your_new_password"
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

class Playlist(BaseModel):
    name: str

class PlaylistEp(BaseModel):
    podcast_id: int
    episode_num: int
    playlist_name: str

class Review(BaseModel):
    rating: int
    comment: str

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

@app.get("/")
async def root():
    return {"message": "Hello World"}

# Create user account
@app.post("/users", status_code=201)
async def createUser(data: UserCreate): # Check if email is already registered
    try:
        with db_cursor() as cursor:
            cursor.execute("SELECT id FROM user WHERE email=%s", (data.email,))
            if cursor.fetchone():
                raise HTTPException(status_code=400, detail=f"Email {data.email} is already registered")

            cursor.execute("SELECT id FROM user WHERE username=%s", (data.username,))
            if cursor.fetchone():
                raise HTTPException(status_code=400, detail=f"Username {data.username} is already taken")

            hashed_password = bcrypt.hashpw(data.password.encode("utf-8"), bcrypt.gensalt())
            cursor.callproc("create_user", (data.email, data.username, hashed_password, data.firstName, data.lastName))
            return {"userCreated": True, "message": f"User {data.username} created successfully"}
    except pymysql.MySQLError as e:
        raise HTTPException(status_code=500, detail=f"Failed to create account")

# Login a registered user
@app.post("/users/login")
async def logInUser(data: UserLogin):
    try:
        with db_cursor() as cursor:
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
    except pymysql.MySQLError as e:
        raise HTTPException(status_code=500, detail=f"Failed to login")

# Get all user details
@app.get("/users/{user_id}")
async def getUser(user_id):
    try:
        with db_cursor() as cursor:
            cursor.callproc("get_user", (user_id,))
            user_info = cursor.fetchone()
            return {"user_info": user_info}
    except pymysql.MySQLError as e:
        raise HTTPException(status_code=500, detail=f"Failed to get users")

# Update user bio
@app.put("/users/{user_id}")
async def updateBio(user_id: int, data: UserBio):
    try:
        with db_cursor() as cursor:
            cursor.execute("SELECT * FROM user WHERE id=%s", (user_id,))
            if not cursor.fetchone():
                raise HTTPException(status_code=404, detail=f"User not found")
            
            cursor.callproc("update_bio", (user_id, data.bio))

            return {"bioUpdated": True, "message": "User bio updated successfully", "bio": data.bio}
    except pymysql.MySQLError as e:
        raise HTTPException(status_code=500, detail=f"Failed to update bio")

# Get all friends for a user
@app.get("/users/{user_id}/friends")
async def getUserFriends(user_id: int):
    try:
        with db_cursor() as cursor:
            cursor.execute("SELECT * FROM user WHERE id=%s", (user_id,))
            if not cursor.fetchone():
                raise HTTPException(status_code=404, detail=f"User not found")
            
            cursor.callproc("get_friends", (user_id,))
            user_friends = cursor.fetchall()
            return {"user_friends": user_friends}
    except pymysql.MySQLError as e:
        raise HTTPException(status_code=500, detail=f"Failed to get friends")

@app.delete("/users/{user_id}/friends/{friend_id}")
### Fill out later ###

# Search for a podcast 
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
        with db_cursor() as cursor:
            cursor.callproc("search_podcasts", (name, genre, language, platform, host, guest, year))
            filtered_podcasts = cursor.fetchall()
            return {"podcasts": filtered_podcasts}
    except pymysql.MySQLError as e:
        raise HTTPException(status_code=500, detail=f"Failed to search podcasts")

# Get all hosts
@app.get("/podcasts/hosts")
async def getHosts():
    try:
        with db_cursor() as cursor:
            cursor.callproc("get_hosts")
            all_hosts = cursor.fetchall()
            return {"hosts": all_hosts}
    except pymysql.MySQLError as e:
        raise HTTPException(status_code=500, detail=f"Failed to get hosts")

# Get all guests
@app.get("/podcasts/guests")
async def getHosts():
    try:
        with db_cursor() as cursor:
            cursor.callproc("get_guests")
            all_guests = cursor.fetchall()
            return {"guests": all_guests}
    except pymysql.MySQLError as e:
        raise HTTPException(status_code=500, detail=f"Failed to get hosts")

# Search for an episode of a podcast
@app.get("/podcasts/{podcast_id}/episodes")
async def searchPodcastEpisodes(
    podcast_id: int,
    num: Optional[int] = None,
    name: Optional[str] = None,
    host: Optional[str] = None,
    guest: Optional[str] = None,
    year: Optional[int] = None
):
    try:
        with db_cursor() as cursor:
            cursor.callproc("search_episodes", (podcast_id, num, name, host, guest, year))
            filtered_episodes = cursor.fetchall()
            return {"episodes": filtered_episodes}
    except pymysql.MySQLError as e:
        raise HTTPException(status_code=500, detail=f"Failed to search episodes")

# Create a playlist for a user
@app.post("/users/{user_id}/playlists")
async def createPlaylist(user_id: int, playlist: Playlist):
    try:
        with db_cursor() as cursor:
            cursor.callproc("create_playlist", (user_id, playlist.name))
            return {"playlistCreated": True, "message": "New playlist created succesfully", "playlist_name": playlist.name}
    except pymysql.err.OperationalError as e:
        error_code, message = e.args
        raise HTTPException(status_code=400, detail=message)

# Get all playlists for a user

# Get all episodes for a playlist

# Add an episode to a playlist
@app.post("/users/{user_id}/playlists/add")
async def addToPlaylist(user_id: int, playlist_ep: PlaylistEp):
    try:
        with db_cursor() as cursor:
            cursor.callproc("add_to_playlist", (user_id, playlist_ep.podcast_id, playlist_ep.episode_num, playlist_ep.playlist_name))
            return {"playlistEpisodeAdded": True,
                    "message": "New episode added to playlist succesfully", "playlist_name": playlist_ep.playlist_name}
    except pymysql.err.OperationalError as e:
        error_code, message = e.args
        raise HTTPException(status_code=400, detail=message)

# Remove an episode from a playlist
@app.delete("/users/{user_id}/playlists/add")
async def removeFromPlaylist(user_id: int, playlist_ep: PlaylistEp):
    try:
        with db_cursor() as cursor:
            cursor.callproc("remove_from_playlist", (user_id, playlist_ep.podcast_id, playlist_ep.episode_num, playlist_ep.playlist_name))
            return {"playlistEpisodeAdded": True,
                 "message": "Episode delete from playlist succesfully", "playlist_name": playlist_ep.playlist_name}
    except pymysql.err.OperationalError as e:
        error_code, message = e.args
        raise HTTPException(status_code=400, detail=message)

# Delete a playlist for a user
@app.delete("/users/{user_id}/playlists")
async def deletePlaylist(user_id: int, playlist: Playlist):
    try:
        with db_cursor() as cursor:
            cursor.callproc("delete_playlist", (user_id, playlist.name))
            return {"playlistDelete": True, "message": "Playlist deleted succesfully", "playlist_name": playlist.name}
    except pymysql.err.OperationalError as e:
        error_code, message = e.args
        raise HTTPException(status_code=400, detail=message)

# Create a podcast review
@app.post("/podcasts/{podcast_id}/reviews/{user_id}")
async def addReviewPodcast(user_id: int, podcast_id: int, review: Review):
    try:
        with db_cursor() as cursor:
            cursor.callproc("insert_podcast_review", (user_id, podcast_id, review.rating, review.comment))
            return {"reviewAdded": True, "message": "Review added successfully", "rating": review.rating, "comment": review.comment}
    except pymysql.err.OperationalError as e:
        error_code, message = e.args
        raise HTTPException(status_code=400, detail=message)

# Get a podcast review
@app.get("/podcasts/{podcast_id}/reviews/{user_id}")
async def getReviewPodcast(user_id: int, podcast_id: int):
    try:
        with db_cursor() as cursor:
            cursor.callproc("get_podcast_review", (user_id, podcast_id))
            review = cursor.fetchall()
            return {"review": review}
    except pymysql.err.OperationalError as e:
        error_code, message = e.args
        raise HTTPException(status_code=400, detail=message)

# Update a podcast review
@app.put("/podcasts/{podcast_id}/reviews/{user_id}")
async def updateReviewPodcast(user_id: int, podcast_id: int, review: Review):
    try:
        with db_cursor() as cursor:
            cursor.callproc("update_podcast_review", (user_id, podcast_id, review.rating, review.comment))
            return {"reviewAdded": True, "message": "Review updated successfully", "rating": review.rating, "comment": review.comment}
    except pymysql.err.OperationalError as e:
        error_code, message = e.args
        raise HTTPException(status_code=400, detail=message)

# Delete a podcast review
@app.delete("/podcasts/{podcast_id}/reviews/{user_id}")
async def deleteUserPodcastReview(podcast_id: int, user_id: int):
    try:
        with db_cursor() as cursor:
            cursor.callproc("delete_podcast_review", (user_id, podcast_id,))
            return {"reviewDelete": True, "message": "Review deleted succesfully"}
    except pymysql.err.OperationalError as e:
        error_code, message = e.args
        raise HTTPException(status_code=400, detail=message)

# Create an episode review
@app.post("/podcasts/{podcast_id}/episodes/{episode_num}/reviews/{user_id}")
async def addReviewEpisode(user_id: int, podcast_id: int, episode_num: int, review: Review):
    try:
        with db_cursor() as cursor:
            cursor.callproc("insert_episode_review", (user_id, podcast_id, episode_num, review.rating, review.comment))
            return {"reviewAdded": True, "message": "Review added successfully", "rating": review.rating, "comment": review.comment}
    except pymysql.err.OperationalError as e:
        error_code, message = e.args
        raise HTTPException(status_code=400, detail=message)

# Get an episode review
@app.get("/podcasts/{podcast_id}/episodes/{episode_num}/reviews/{user_id}")
async def getReviewPodcast(podcast_id: int, episode_num: int, user_id: int):
    try:
        with db_cursor() as cursor:
            cursor.callproc("get_episode_review", (user_id, podcast_id, episode_num))
            review = cursor.fetchall()
            return {"review": review}
    except pymysql.err.OperationalError as e:
        error_code, message = e.args
        raise HTTPException(status_code=400, detail=message)

# Update an episode review
@app.put("/podcasts/{podcast_id}/episodes/{episode_num}/reviews/{user_id}")
async def updateReviewEpisode(user_id: int, podcast_id: int, episode_num: int, review: Review):
    try:
        with db_cursor() as cursor:
            cursor.callproc("update_episode_review", (user_id, podcast_id, episode_num, review.rating, review.comment))
            connection.commit()
            return {"reviewUpdated": True, "message": "Review updated successfully", "rating": review.rating, "comment": review.comment}
    except pymysql.err.OperationalError as e:
        error_code, message = e.args
        raise HTTPException(status_code=400, detail=message)

# Delete an episode review
@app.delete("/podcasts/{podcast_id}/episodes/{episode_num}/reviews/{user_id}")
async def deleteUserEpisodeReview(podcast_id: int, episode_num: int, user_id: int):
    try:
        with db_cursor() as cursor:
            cursor.callproc("delete_episode_review", (user_id, podcast_id, episode_num,))
            return {"reviewDelete": True, "message": "Review deleted succesfully"}
    except pymysql.err.OperationalError as e:
        error_code, message = e.args
        raise HTTPException(status_code=400, detail=message)

# Get all derived podcast ratings for a user
@app.get("/podcasts/{podcast_id}/ratings/{user_id}")
async def getPodcastDerivedRatings(podcast_id: int, user_id: int):
    try:
        with db_cursor() as cursor:
            cursor.callproc("get_global_podcast_avg_rating", (podcast_id,))
            global_avg_rating = cursor.fetchone()

            cursor.callproc("get_global_podcast_avg_rating_by_episode", (podcast_id,))
            global_avg_rating_by_ep = cursor.fetchone()
            
            stmt = "SELECT get_user_friends_podcast_avg_rating(%s, %s)"
            cursor.execute(stmt, (user_id, podcast_id,))
            friends_avg_rating = cursor.fetchone()

            stmt = "SELECT get_user_friends_podcast_avg_rating_by_episode(%s, %s)"
            cursor.execute(stmt, (user_id, podcast_id,))
            friends_avg_rating_by_ep = cursor.fetchone()
            return {"global_avg_rating": list(global_avg_rating.values())[0],
                    "global_avg_rating_by_ep": list(global_avg_rating_by_ep.values())[0],
                    "friends_avg_rating": list(friends_avg_rating.values())[0],
                    "friends_avg_rating_by_ep": list(friends_avg_rating_by_ep.values())[0]}
    except pymysql.err.OperationalError as e:
        error_code, message = e.args
        raise HTTPException(status_code=400, detail=message)

# Get all derived episode ratings for a user
@app.get("/podcasts/{podcast_id}/episodes/{episode_num}/ratings/{user_id}")
async def getEpisodeDerivedRatings(podcast_id: int, episode_num: int, user_id: int):
    try:
        with db_cursor() as cursor:
            stmt = "SELECT get_global_episode_avg_rating(%s, %s)"
            cursor.execute(stmt, (podcast_id, episode_num,))
            global_avg_rating = cursor.fetchone()

            stmt = "SELECT get_user_friends_episode_avg_rating(%s, %s, %s)"
            cursor.execute(stmt, (user_id, podcast_id, episode_num,))
            friends_avg_rating = cursor.fetchone()
            
            return {"global_episode_avg_rating": list(global_avg_rating.values())[0],
                    "friends_episode_avg_rating": list(friends_avg_rating.values())[0]}
    except pymysql.err.OperationalError as e:
        error_code, message = e.args
        raise HTTPException(status_code=400, detail=message)