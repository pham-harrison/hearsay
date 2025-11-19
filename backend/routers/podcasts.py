from fastapi import APIRouter, HTTPException
from typing import Optional
from ..db import db_cursor
from pydantic import BaseModel
import pymysql

class Review(BaseModel):
    rating: int
    comment: str

router = APIRouter(prefix="/podcasts")


# Search for a podcast 
@router.get("/")
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
@router.get("/hosts")
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
@router.get("/guests")
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
@router.get("/{podcast_id}/episodes")
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
    
# Create a podcast review
@router.post("/{podcast_id}/reviews/{user_id}", status_code=201)
async def addReviewPodcast(user_id: int, podcast_id: int, review: Review):
    try:
        with db_cursor() as cursor:
            cursor.callproc("insert_podcast_review", (user_id, podcast_id, review.rating, review.comment))
            return {"reviewAdded": True, "message": "Review added successfully", "rating": review.rating, "comment": review.comment}
    except pymysql.err.OperationalError as e:
        error_code, message = e.args
        raise HTTPException(status_code=400, detail=message)

# Get a podcast review
@router.get("/{podcast_id}/reviews/{user_id}")
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
@router.put("/{podcast_id}/reviews/{user_id}")
async def updateReviewPodcast(user_id: int, podcast_id: int, review: Review):
    try:
        with db_cursor() as cursor:
            cursor.callproc("update_podcast_review", (user_id, podcast_id, review.rating, review.comment))
            return {"reviewAdded": True, "message": "Review updated successfully", "rating": review.rating, "comment": review.comment}
    except pymysql.err.OperationalError as e:
        error_code, message = e.args
        raise HTTPException(status_code=400, detail=message)

# Delete a podcast review
@router.delete("/{podcast_id}/reviews/{user_id}")
async def deleteUserPodcastReview(podcast_id: int, user_id: int):
    try:
        with db_cursor() as cursor:
            cursor.callproc("delete_podcast_review", (user_id, podcast_id,))
            return {"reviewDelete": True, "message": "Review deleted successfully"}
    except pymysql.err.OperationalError as e:
        error_code, message = e.args
        raise HTTPException(status_code=400, detail=message)

# Create an episode review
@router.post("/{podcast_id}/episodes/{episode_num}/reviews/{user_id}", status_code=201)
async def addReviewEpisode(user_id: int, podcast_id: int, episode_num: int, review: Review):
    try:
        with db_cursor() as cursor:
            cursor.callproc("insert_episode_review", (user_id, podcast_id, episode_num, review.rating, review.comment))
            return {"reviewAdded": True, "message": "Review added successfully", "rating": review.rating, "comment": review.comment}
    except pymysql.err.OperationalError as e:
        error_code, message = e.args
        raise HTTPException(status_code=400, detail=message)

# Get an episode review
@router.get("/{podcast_id}/episodes/{episode_num}/reviews/{user_id}")
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
@router.put("/{podcast_id}/episodes/{episode_num}/reviews/{user_id}")
async def updateReviewEpisode(user_id: int, podcast_id: int, episode_num: int, review: Review):
    try:
        with db_cursor() as cursor:
            cursor.callproc("update_episode_review", (user_id, podcast_id, episode_num, review.rating, review.comment))
            return {"reviewUpdated": True, "message": "Review updated successfully", "rating": review.rating, "comment": review.comment}
    except pymysql.err.OperationalError as e:
        error_code, message = e.args
        raise HTTPException(status_code=400, detail=message)

# Delete an episode review
@router.delete("/{podcast_id}/episodes/{episode_num}/reviews/{user_id}")
async def deleteUserEpisodeReview(podcast_id: int, episode_num: int, user_id: int):
    try:
        with db_cursor() as cursor:
            cursor.callproc("delete_episode_review", (user_id, podcast_id, episode_num,))
            return {"reviewDelete": True, "message": "Review deleted successfully"}
    except pymysql.err.OperationalError as e:
        error_code, message = e.args
        raise HTTPException(status_code=400, detail=message)

# Get all derived podcast ratings for a user
@router.get("/{podcast_id}/ratings/{user_id}")
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
@router.get("/{podcast_id}/episodes/{episode_num}/ratings/{user_id}")
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