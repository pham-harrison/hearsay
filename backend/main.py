from fastapi import FastAPI, HTTPException
from pydantic import BaseModel, EmailStr
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

@app.get("/")
async def root():
    return {"message": "Hello World"}

# Create user account
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
        cursor.callproc("create_user", (data.email, data.username, hashed_password, data.firstName, data.lastName))
        connection.commit()
        return {"userCreated": True, "message": f"User {data.username} created successfully"}
    finally:
        connection.close()

# Login a registered user
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

# Get all user details
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
        return {"user_info": user_info}
    finally:
        connection.close()

# Update user bio
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
        cursor.execute("SELECT * FROM user WHERE id=%s", (user_id,))
        if not cursor.fetchone():
            raise HTTPException(status_code=404, detail=f"User not found")
        
        cursor.callproc("update_bio", (user_id, data.bio))
        connection.commit()

        return {"bioUpdated": True, "message": "User bio updated successfully", "bio": data.bio}
    finally:
        connection.close()

# Get all friends for a user
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
        cursor.execute("SELECT * FROM user WHERE id=%s", (user_id,))
        if not cursor.fetchone():
            raise HTTPException(status_code=404, detail=f"User not found")
        
        cursor.callproc("get_friends", (user_id,))
        user_friends = cursor.fetchall()
        return {"user_friends": user_friends}
    finally:
        connection.close()

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
    except pymysql.MySQLError as e:
        raise HTTPException(status_code=500, detail=f"Failed to search podcasts")
    finally:
        connection.close()

# Get all hosts
@app.get("/podcasts/hosts")
async def getHosts():
    try:
        connection = pymysql.connect(
            host=HOST,
            user=DB_USER,
            password=DB_PASSWORD,
            database=DATABASE,
            cursorclass=pymysql.cursors.DictCursor
        )
        cursor = connection.cursor()
        cursor.callproc("get_hosts")
        all_hosts = cursor.fetchall()
        return {"hosts": all_hosts}
    except pymysql.MySQLError as e:
        raise HTTPException(status_code=500, detail=f"Failed to get hosts")
    finally:
        connection.close()

# Get all guests
@app.get("/podcasts/guests")
async def getHosts():
    try:
        connection = pymysql.connect(
            host=HOST,
            user=DB_USER,
            password=DB_PASSWORD,
            database=DATABASE,
            cursorclass=pymysql.cursors.DictCursor
        )
        cursor = connection.cursor()
        cursor.callproc("get_guests")
        all_guests = cursor.fetchall()
        return {"guests": all_guests}
    except pymysql.MySQLError as e:
        raise HTTPException(status_code=500, detail=f"Failed to get hosts")
    finally:
        connection.close()

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
        connection = pymysql.connect(
            host=HOST,
            user=DB_USER,
            password=DB_PASSWORD,
            database=DATABASE,
            cursorclass=pymysql.cursors.DictCursor
        )
        cursor = connection.cursor()
        cursor.callproc("search_episodes", (podcast_id, num, name, host, guest, year))
        filtered_episodes = cursor.fetchall()
        return {"episodes": filtered_episodes}
    except pymysql.MySQLError as e:
        raise HTTPException(status_code=500, detail=f"Failed to search episodes")
    finally:
        connection.close()

# Create a playlist for a user
@app.post("/users/{user_id}/playlists")
async def createPlaylist(user_id: int, playlist: Playlist):
    try:
        connection = pymysql.connect(
            host=HOST,
            user=DB_USER,
            password=DB_PASSWORD,
            database=DATABASE,
            cursorclass=pymysql.cursors.DictCursor
        )

        cursor = connection.cursor()
        cursor.callproc("create_playlist", (user_id, playlist.name))
        connection.commit()

        return {"playlistCreated": True, "message": "New playlist created succesfully", "playlist_name": playlist.name}
    except pymysql.err.OperationalError as e:
        error_code, message = e.args
        raise HTTPException(status_code=400, detail=message)
    finally:
        connection.close()

# Delete a playlist for a user
@app.delete("/users/{user_id}/playlists")
async def deletePlaylist(user_id: int, playlist: Playlist):
    try:
        connection = pymysql.connect(
            host=HOST,
            user=DB_USER,
            password=DB_PASSWORD,
            database=DATABASE,
            cursorclass=pymysql.cursors.DictCursor
        )

        cursor = connection.cursor()
       
        
        cursor.callproc("delete_playlist", (user_id, playlist.name))
        connection.commit()

        return {"playlistDelete": True, "message": "Playlist deleted succesfully", "playlist_name": playlist.name}
    except pymysql.err.OperationalError as e:
        error_code, message = e.args
        raise HTTPException(status_code=400, detail=message)
    finally:
        connection.close()

# Add an episode to a playlist
@app.post("/users/{user_id}/playlists/add")
async def addToPlaylist(user_id: int, playlist_ep: PlaylistEp):
    try:
        connection = pymysql.connect(
            host=HOST,
            user=DB_USER,
            password=DB_PASSWORD,
            database=DATABASE,
            cursorclass=pymysql.cursors.DictCursor
        )

        cursor = connection.cursor()
        cursor.callproc("add_to_playlist", (user_id, playlist_ep.podcast_id, playlist_ep.episode_num, playlist_ep.playlist_name))
        connection.commit()

        return {"playlistEpisodeAdded": True,
                 "message": "New episode added to playlist succesfully", "playlist_name": playlist_ep.playlist_name}
    except pymysql.err.OperationalError as e:
        error_code, message = e.args
        raise HTTPException(status_code=400, detail=message)
    finally:
        connection.close()

# Remove an episode from a playlist
@app.delete("/users/{user_id}/playlists/add")
async def removeFromPlaylist(user_id: int, playlist_ep: PlaylistEp):
    try:
        connection = pymysql.connect(
            host=HOST,
            user=DB_USER,
            password=DB_PASSWORD,
            database=DATABASE,
            cursorclass=pymysql.cursors.DictCursor
        )

        cursor = connection.cursor()
        cursor.callproc("remove_from_playlist", (user_id, playlist_ep.podcast_id, playlist_ep.episode_num, playlist_ep.playlist_name))
        connection.commit()

        return {"playlistEpisodeAdded": True,
                 "message": "Episode delete from playlist succesfully", "playlist_name": playlist_ep.playlist_name}
    except pymysql.err.OperationalError as e:
        error_code, message = e.args
        raise HTTPException(status_code=400, detail=message)
    finally:
        connection.close()

# Create a podcast review
@app.post("/podcasts/{podcast_id}/review/{user_id}")
async def addReviewPodcast(user_id: int, podcast_id: int, review: Review):
    try:
        connection = pymysql.connect(
            host=HOST,
            user=DB_USER,
            password=DB_PASSWORD,
            database=DATABASE,
            cursorclass=pymysql.cursors.DictCursor
        )

        cursor = connection.cursor()
        cursor.callproc("insert_podcast_review", (user_id, podcast_id, review.rating, review.comment))
        connection.commit()
        return {"reviewAdded": True, "message": "Review added successfully", "rating": review.rating, "comment": review.comment}
    except pymysql.err.OperationalError as e:
        error_code, message = e.args
        raise HTTPException(status_code=400, detail=message)
    finally:
        connection.close()

# Update a podcast review
@app.put("/podcasts/{podcast_id}/review/{user_id}")
async def updateReviewPodcast(user_id: int, podcast_id: int, review: Review):
    try:
        connection = pymysql.connect(
            host=HOST,
            user=DB_USER,
            password=DB_PASSWORD,
            database=DATABASE,
            cursorclass=pymysql.cursors.DictCursor
        )

        cursor = connection.cursor()
        cursor.callproc("update_podcast_review", (user_id, podcast_id, review.rating, review.comment))
        connection.commit()
        return {"reviewAdded": True, "message": "Review updated successfully", "rating": review.rating, "comment": review.comment}
    except pymysql.err.OperationalError as e:
        error_code, message = e.args
        raise HTTPException(status_code=400, detail=message)
    finally:
        connection.close()

# Create an episode review
@app.post("/podcasts/{podcast_id}/{episode_num}/review/{user_id}")
async def addReviewEpisode(user_id: int, podcast_id: int, episode_num: int, review: Review):
    try:
        connection = pymysql.connect(
            host=HOST,
            user=DB_USER,
            password=DB_PASSWORD,
            database=DATABASE,
            cursorclass=pymysql.cursors.DictCursor
        )

        cursor = connection.cursor()
        cursor.callproc("insert_episode_review", (user_id, podcast_id, episode_num, review.rating, review.comment))
        connection.commit()
        return {"reviewAdded": True, "message": "Review added successfully", "rating": review.rating, "comment": review.comment}
    except pymysql.err.OperationalError as e:
        error_code, message = e.args
        raise HTTPException(status_code=400, detail=message)
    finally:
        connection.close()

# Update an episode review
@app.put("/podcasts/{podcast_id}/{episode_num}/review/{user_id}")
async def updateReviewEpisode(user_id: int, podcast_id: int, episode_num: int, review: Review):
    try:
        connection = pymysql.connect(
            host=HOST,
            user=DB_USER,
            password=DB_PASSWORD,
            database=DATABASE,
            cursorclass=pymysql.cursors.DictCursor
        )

        cursor = connection.cursor()
        cursor.callproc("update_episode_review", (user_id, podcast_id, episode_num, review.rating, review.comment))
        connection.commit()
        return {"reviewUpdated": True, "message": "Review updated successfully", "rating": review.rating, "comment": review.comment}
    except pymysql.err.OperationalError as e:
        error_code, message = e.args
        raise HTTPException(status_code=400, detail=message)
    finally:
        connection.close()

# Delete a podcast review
@app.delete("/podcasts/{podcast_id}/review/{user_id}")
async def deleteUserPodcastReview(podcast_id: int, user_id: int):
    try:
        connection = pymysql.connect(
            host=HOST,
            user=DB_USER,
            password=DB_PASSWORD,
            database=DATABASE,
            cursorclass=pymysql.cursors.DictCursor
        )

        cursor = connection.cursor()
        cursor.callproc("delete_podcast_review", (user_id, podcast_id,))
        connection.commit()

        return {"reviewDelete": True, "message": "Review deleted succesfully"}
    except pymysql.err.OperationalError as e:
        error_code, message = e.args
        raise HTTPException(status_code=400, detail=message)
    finally:
        connection.close()

# Delete an episode review
@app.delete("/podcasts/{podcast_id}/{episode_num}/review/{user_id}")
async def deleteUserEpisodeReview(podcast_id: int, episode_num: int, user_id: int):
    try:
        connection = pymysql.connect(
            host=HOST,
            user=DB_USER,
            password=DB_PASSWORD,
            database=DATABASE,
            cursorclass=pymysql.cursors.DictCursor
        )

        cursor = connection.cursor()
        cursor.callproc("delete_episode_review", (user_id, podcast_id, episode_num,))
        connection.commit()

        return {"reviewDelete": True, "message": "Review deleted succesfully"}
    except pymysql.err.OperationalError as e:
        error_code, message = e.args
        raise HTTPException(status_code=400, detail=message)
    finally:
        connection.close()

# Get rating scores for a podcast
@app.get("/podcasts/{podcast_id}/global")
async def getPodcastGlobalAvg(podcast_id: int):
    try:
        connection = pymysql.connect(
            host=HOST,
            user=DB_USER,
            password=DB_PASSWORD,
            database=DATABASE,
            cursorclass=pymysql.cursors.DictCursor
        )

        cursor = connection.cursor()
        cursor.callproc("get_global_podcast_avg_rating", (podcast_id,))
        global_avg_rating = cursor.fetchone()
        return global_avg_rating
    except pymysql.err.OperationalError as e:
        error_code, message = e.args
        raise HTTPException(status_code=400, detail=message)
    finally:
        connection.close()

@app.get("/podcasts/{podcast_id}/global_ep")
async def getPodcastGlobalAvgEp(podcast_id: int):
    try:
        connection = pymysql.connect(
            host=HOST,
            user=DB_USER,
            password=DB_PASSWORD,
            database=DATABASE,
            cursorclass=pymysql.cursors.DictCursor
        )

        cursor = connection.cursor()
        cursor.callproc("get_global_podcast_avg_rating_by_episode", (podcast_id,))
        global_avg_rating_by_ep = cursor.fetchone()
        return global_avg_rating_by_ep
    except pymysql.err.OperationalError as e:
        error_code, message = e.args
        raise HTTPException(status_code=400, detail=message)
    finally:
        connection.close()

@app.get("/podcasts/{podcast_id}/friends/{user_id}")
async def getPodcastFriendsAvg(podcast_id: int, user_id: int):
    try:
        connection = pymysql.connect(
            host=HOST,
            user=DB_USER,
            password=DB_PASSWORD,
            database=DATABASE,
            cursorclass=pymysql.cursors.DictCursor
        )

        cursor = connection.cursor()
        stmt = "SELECT get_user_friends_podcast_avg_rating(%s, %s)"
        cursor.execute(stmt, (user_id, podcast_id,))
        friends_avg_rating = cursor.fetchone()
        return friends_avg_rating
    except pymysql.err.OperationalError as e:
        message = e.args
        raise HTTPException(status_code=400, detail=message)
    finally:
        connection.close()

@app.get("/podcasts/{podcast_id}/friends_ep/{user_id}")
async def getPodcastFriendsAvgEp(podcast_id: int, user_id: int):
    try:
        connection = pymysql.connect(
            host=HOST,
            user=DB_USER,
            password=DB_PASSWORD,
            database=DATABASE,
            cursorclass=pymysql.cursors.DictCursor
        )

        cursor = connection.cursor()
        stmt = "SELECT get_user_friends_podcast_avg_rating_by_episode(%s, %s)"
        cursor.execute(stmt, (user_id, podcast_id,))
        friends_avg_rating_ep = cursor.fetchone()
        return friends_avg_rating_ep
    except pymysql.err.OperationalError as e:
        message = e.args
        raise HTTPException(status_code=400, detail=message)
    finally:
        connection.close()

@app.get("/podcasts/{podcast_id}/review/{user_id}")
async def getUserPodcastReview(podcast_id: int, user_id: int):
    try:
        connection = pymysql.connect(
            host=HOST,
            user=DB_USER,
            password=DB_PASSWORD,
            database=DATABASE,
            cursorclass=pymysql.cursors.DictCursor
        )

        cursor = connection.cursor()
        cursor.callproc("get_user_podcast_rating", (user_id, podcast_id,))
        rating_by_user = cursor.fetchone()
        return rating_by_user
    except pymysql.err.OperationalError as e:
        error_code, message = e.args
        raise HTTPException(status_code=400, detail=message)
    finally:
        connection.close()

@app.get("/podcasts/{podcast_id}/{episode_num}/review/{user_id}")
async def getUserEpisodeReview(podcast_id: int, episode_num: int, user_id: int):
    try:
        connection = pymysql.connect(
            host=HOST,
            user=DB_USER,
            password=DB_PASSWORD,
            database=DATABASE,
            cursorclass=pymysql.cursors.DictCursor
        )

        cursor = connection.cursor()
        cursor.callproc("get_user_episode_rating", (user_id, podcast_id, episode_num,))
        rating_by_user = cursor.fetchone()
        return rating_by_user
    except pymysql.err.OperationalError as e:
        error_code, message = e.args
        raise HTTPException(status_code=400, detail=message)
    finally:
        connection.close()

@app.get("/podcasts/{podcast_id}/{episode_num}/global")
async def getPodcastGlobalAvgEp(podcast_id: int, episode_num: int):
    try:
        connection = pymysql.connect(
            host=HOST,
            user=DB_USER,
            password=DB_PASSWORD,
            database=DATABASE,
            cursorclass=pymysql.cursors.DictCursor
        )

        cursor = connection.cursor()
        stmt = "SELECT get_global_episode_avg_rating(%s, %s)"
        cursor.execute(stmt, (podcast_id, episode_num,))
        global_avg_rating = cursor.fetchone()
        return global_avg_rating
    except pymysql.err.OperationalError as e:
        error_code, message = e.args
        raise HTTPException(status_code=400, detail=message)
    finally:
        connection.close()

@app.get("/podcasts/{podcast_id}/{episode_num}/friends/{user_id}")
async def getPodcastGlobalAvgEp(podcast_id: int, episode_num: int, user_id: int):
    try:
        connection = pymysql.connect(
            host=HOST,
            user=DB_USER,
            password=DB_PASSWORD,
            database=DATABASE,
            cursorclass=pymysql.cursors.DictCursor
        )

        cursor = connection.cursor()
        stmt = "SELECT get_user_friends_episode_avg_rating(%s, %s, %s)"
        cursor.execute(stmt, (user_id, podcast_id, episode_num,))
        global_avg_rating = cursor.fetchone()
        return global_avg_rating
    except pymysql.err.OperationalError as e:
        error_code, message = e.args
        raise HTTPException(status_code=400, detail=message)
    finally:
        connection.close()