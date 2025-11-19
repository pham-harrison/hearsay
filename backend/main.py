from fastapi import FastAPI, HTTPException
from pydantic import BaseModel

import pymysql
import bcrypt
from typing import Optional
from routers.users import router as users_router
app = FastAPI()

HOST = "localhost"
DB_USER = "root"
DB_PASSWORD = "root1234"
DATABASE = "hearsay_db"

class PlaylistEp(BaseModel):
    podcast_id: int
    episode_num: int

class Review(BaseModel):
    rating: int
    comment: str

from db import db_cursor

app.include_router(users_router)

@app.get("/")
async def root():
    return {"message": "Hello World"}

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
            host_first_name, host_last_name = None, None
            if host:
                host_name_parts = host.split()
                host_first_name, host_last_name = host_name_parts[0], host_name_parts[1]

            guest_first_name, guest_last_name = None, None
            if guest:
                guest_name_parts = guest.split()
                guest_first_name, guest_last_name = guest_name_parts[0], guest_name_parts[1]
                
            cursor.callproc("search_podcasts", (name, genre, language, platform, host_first_name, host_last_name, guest_first_name, guest_last_name, year))
            filtered_podcasts = cursor.fetchall()
            return filtered_podcasts
    except pymysql.err.OperationalError as e:
        error_code, message = e.args
        raise HTTPException(status_code=400, detail=message)

# Get all hosts
@app.get("/podcasts/hosts")
async def getHosts():
    try:
        with db_cursor() as cursor:
            cursor.callproc("get_hosts")
            all_hosts = cursor.fetchall()
            return all_hosts
    except pymysql.err.OperationalError as e:
        error_code, message = e.args
        raise HTTPException(status_code=400, detail=message)

# Get all guests
@app.get("/podcasts/guests")
async def getHosts():
    try:
        with db_cursor() as cursor:
            cursor.callproc("get_guests")
            all_guests = cursor.fetchall()
            return all_guests
    except pymysql.err.OperationalError as e:
        error_code, message = e.args
        raise HTTPException(status_code=400, detail=message)

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
        host_first_name, host_last_name = None, None
        if host:
            host_name_parts = host.split()
            host_first_name, host_last_name = host_name_parts[0], host_name_parts[1]

        guest_first_name, guest_last_name = None, None
        if guest:
            guest_name_parts = guest.split()
            guest_first_name, guest_last_name = guest_name_parts[0], guest_name_parts[1]

        
        with db_cursor() as cursor:
            cursor.callproc("search_episodes", (podcast_id, num, name, host_first_name, host_last_name, guest_first_name, guest_last_name, year))
            filtered_episodes = cursor.fetchall()
            return filtered_episodes
    except pymysql.err.OperationalError as e:
        error_code, message = e.args
        raise HTTPException(status_code=400, detail=message)

# Create a playlist for a user
@app.post("/users/{user_id}/playlists/{playlist_name}", status_code=201)
async def createPlaylist(user_id: int, playlist_name: str):
    try:
        with db_cursor() as cursor:
            cursor.callproc("create_playlist", (user_id, playlist_name))
            return {"playlistCreated": True, "message": "New playlist created successfully", "playlist_name": playlist_name}
    except pymysql.err.OperationalError as e:
        error_code, message = e.args
        raise HTTPException(status_code=400, detail=message)

# Get all playlists for a user
@app.get("/users/{user_id}/playlists/")
async def getPlaylist(user_id: int):
    try:
        with db_cursor() as cursor:
            cursor.callproc("get_playlists", (user_id,))
            return cursor.fetchall()
    except pymysql.err.OperationalError as e:
        error_code, message = e.args
        raise HTTPException(status_code=400, detail=message)

# Get all episodes for a playlist
@app.get("/users/{user_id}/playlists/{playlist_name}/episodes")
async def createPlaylist(user_id: int, playlist_name: str):
    try:
        with db_cursor() as cursor:
            cursor.callproc("get_episodes_in_playlist", (user_id, playlist_name))
            return cursor.fetchall()
    except pymysql.err.OperationalError as e:
        error_code, message = e.args
        raise HTTPException(status_code=400, detail=message)

# Add an episode to a playlist
@app.post("/users/{user_id}/playlists/{playlist_name}/episodes", status_code=201)
async def addToPlaylist(user_id: int, playlist_name: str, playlist_ep: PlaylistEp):
    try:
        with db_cursor() as cursor:
            cursor.callproc("add_episode_to_playlist", (user_id, playlist_ep.podcast_id, playlist_ep.episode_num, playlist_name))
            return {"playlistEpisodeAdded": True,
                    "message": "New episode added to playlist successfully", "playlist_name": playlist_name}
    except pymysql.err.OperationalError as e:
        error_code, message = e.args
        raise HTTPException(status_code=400, detail=message)

# Remove an episode from a playlist
@app.delete("/users/{user_id}/playlists/{playlist_name}/episodes")
async def removeFromPlaylist(user_id: int, playlist_name: str, playlist_ep: PlaylistEp):
    try:
        with db_cursor() as cursor:
            cursor.callproc("remove_episode_from_playlist", (user_id, playlist_ep.podcast_id, playlist_ep.episode_num, playlist_name))
            return {"playlistEpisodeAdded": True,
                 "message": "Episode deleted from playlist successfully", "playlist_name": playlist_name}
    except pymysql.err.OperationalError as e:
        error_code, message = e.args
        raise HTTPException(status_code=400, detail=message)

# Delete a playlist for a user
@app.delete("/users/{user_id}/playlists/{playlist_name}")
async def deletePlaylist(user_id: int, playlist_name: str):
    try:
        with db_cursor() as cursor:
            cursor.callproc("delete_playlist", (user_id, playlist_name,))
            return {"playlistDelete": True, "message": "Playlist deleted successfully", "playlist_name": playlist_name}
    except pymysql.err.OperationalError as e:
        error_code, message = e.args
        raise HTTPException(status_code=400, detail=message)

# Create a podcast review
@app.post("/podcasts/{podcast_id}/reviews/{user_id}", status_code=201)
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
            podcast_review = cursor.fetchone()
            return podcast_review
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
            return {"reviewDelete": True, "message": "Review deleted successfully"}
    except pymysql.err.OperationalError as e:
        error_code, message = e.args
        raise HTTPException(status_code=400, detail=message)

# Create an episode review
@app.post("/podcasts/{podcast_id}/episodes/{episode_num}/reviews/{user_id}", status_code=201)
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
            episode_review = cursor.fetchone()
            return episode_review
    except pymysql.err.OperationalError as e:
        error_code, message = e.args
        raise HTTPException(status_code=400, detail=message)

# Update an episode review
@app.put("/podcasts/{podcast_id}/episodes/{episode_num}/reviews/{user_id}")
async def updateReviewEpisode(user_id: int, podcast_id: int, episode_num: int, review: Review):
    try:
        with db_cursor() as cursor:
            cursor.callproc("update_episode_review", (user_id, podcast_id, episode_num, review.rating, review.comment))
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
            return {"reviewDelete": True, "message": "Review deleted successfully"}
    except pymysql.err.OperationalError as e:
        error_code, message = e.args
        raise HTTPException(status_code=400, detail=message)

# Get all derived podcast ratings for a user
@app.get("/podcasts/{podcast_id}/ratings/{user_id}")
async def getPodcastDerivedRatings(podcast_id: int, user_id: int):
    try:
        with db_cursor() as cursor:
            stmt = "SELECT get_global_podcast_avg_rating(%s)"
            cursor.execute(stmt, (podcast_id,))
            global_avg_rating = cursor.fetchone()

            stmt = "SELECT get_global_podcast_avg_rating_by_episode(%s)"
            cursor.execute(stmt, (podcast_id,))
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