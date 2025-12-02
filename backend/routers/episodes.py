from fastapi import APIRouter, HTTPException, Depends
from typing import Optional
from .auth import getCurrentUser
from ..db import db_cursor
from pydantic import BaseModel
import pymysql
from ..utils.convertSnakeToCamel import convertListKeyToCamel, convertDictKeyToCamel


class Review(BaseModel):
    rating: int
    comment: str


router = APIRouter()


# Search for an episode of a podcast
@router.get("/")
async def searchPodcastEpisodes(
    podcast_id: int,
    num: Optional[int] = None,
    name: Optional[str] = None,
    host: Optional[str] = None,
    guest: Optional[str] = None,
    year: Optional[int] = None,
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
            cursor.callproc(
                "search_episodes",
                (
                    podcast_id,
                    num,
                    name,
                    host_first_name,
                    host_last_name,
                    guest_first_name,
                    guest_last_name,
                    year,
                ),
            )
            filtered_episodes = cursor.fetchall()
            return filtered_episodes
    except pymysql.err.OperationalError as e:
        error_code, message = e.args
        raise HTTPException(status_code=400, detail=message)


@router.get("/filters")
async def getFilters(podcast_id: int):
    try:
        with db_cursor() as cursor:
            filters = {}

            cursor.callproc("get_podcast_hosts", (podcast_id,))
            host_rows = cursor.fetchall()
            hosts = [f"{row['first_name']} {row['last_name']}" for row in host_rows]
            filters["hosts"] = hosts

            cursor.callproc("get_podcast_guests", (podcast_id,))
            guest_rows = cursor.fetchall()
            guests = [f"{row["first_name"]} {row["last_name"]}" for row in guest_rows]
            filters["guests"] = guests

            return filters
    except pymysql.err.OperationalError as e:
        error_code, message = e.args
        raise HTTPException(status_code=400, detail=message)


# Get info about an episode
@router.get("/{episode_num}")
async def getPodcast(podcast_id: int, episode_num: int):
    try:
        with db_cursor() as cursor:
            cursor.callproc("get_episode", (podcast_id, episode_num))
            result = cursor.fetchone()
            if not result:
                return HTTPException(status_code=404, detail="Episode not found")
            return convertDictKeyToCamel(result)
    except pymysql.err.OperationalError as e:
        error_code, message = e.args
        raise HTTPException(status_code=400, detail=message)


# Create an episode review
@router.post("/{episode_num}/reviews/{user_id}", status_code=201)
async def addReviewEpisode(
    user_id: int,
    podcast_id: int,
    episode_num: int,
    review: Review,
    current_user: int = Depends(getCurrentUser),
):
    if current_user != user_id:
        raise HTTPException(
            status_code=400, detail="Unauthorized to make changes to user"
        )
    try:
        with db_cursor() as cursor:
            cursor.callproc(
                "insert_episode_review",
                (user_id, podcast_id, episode_num, review.rating, review.comment),
            )
            return {
                "reviewAdded": True,
                "message": "Review added successfully",
                "rating": review.rating,
                "comment": review.comment,
            }
    except pymysql.err.OperationalError as e:
        error_code, message = e.args
        raise HTTPException(status_code=400, detail=message)


# Get an episode review
@router.get("/{episode_num}/reviews/{user_id}")
async def getReviewEpisode(podcast_id: int, episode_num: int, user_id: int):
    try:
        with db_cursor() as cursor:
            cursor.callproc("get_episode_review", (user_id, podcast_id, episode_num))
            result = cursor.fetchone()
            if not result:
                return HTTPException(
                    status_code=404, detail="User episode review not found"
                )
            return convertDictKeyToCamel(result)
    except pymysql.err.OperationalError as e:
        error_code, message = e.args
        raise HTTPException(status_code=400, detail=message)


# Update an episode review
@router.put("/{episode_num}/reviews/{user_id}")
async def updateReviewEpisode(
    user_id: int,
    podcast_id: int,
    episode_num: int,
    review: Review,
    current_user: int = Depends(getCurrentUser),
):
    if current_user != user_id:
        raise HTTPException(
            status_code=400, detail="Unauthorized to make changes to user"
        )
    try:
        with db_cursor() as cursor:
            cursor.callproc(
                "update_episode_review",
                (user_id, podcast_id, episode_num, review.rating, review.comment),
            )
            return {
                "reviewUpdated": True,
                "message": "Review updated successfully",
                "rating": review.rating,
                "comment": review.comment,
            }
    except pymysql.err.OperationalError as e:
        error_code, message = e.args
        raise HTTPException(status_code=400, detail=message)


# Delete an episode review
@router.delete("/{episode_num}/reviews/{user_id}")
async def deleteUserEpisodeReview(
    podcast_id: int,
    episode_num: int,
    user_id: int,
    current_user: int = Depends(getCurrentUser),
):
    if current_user != user_id:
        raise HTTPException(
            status_code=400, detail="Unauthorized to make changes to user"
        )
    try:
        with db_cursor() as cursor:
            cursor.callproc(
                "delete_episode_review",
                (
                    user_id,
                    podcast_id,
                    episode_num,
                ),
            )
            return {"reviewDelete": True, "message": "Review deleted successfully"}
    except pymysql.err.OperationalError as e:
        error_code, message = e.args
        raise HTTPException(status_code=400, detail=message)


# Get all friend reviews of an episode
@router.get("/{episode_num}/reviews/{user_id}/friends")
async def getAllFriendsReviewsEpisode(podcast_id: int, episode_num: int, user_id: int):
    try:
        with db_cursor() as cursor:
            cursor.callproc(
                "get_user_friends_episode_review", (user_id, podcast_id, episode_num)
            )
            return convertListKeyToCamel(cursor.fetchall())
    except pymysql.err.OperationalError as e:
        error_code, message = e.args
        raise HTTPException(status_code=400, detail=message)


# Get all derived episode ratings for a user
@router.get("/{episode_num}/ratings")
async def getEpisodeGlobalRatings(podcast_id: int, episode_num: int):
    try:
        with db_cursor() as cursor:
            stmt = "SELECT get_global_episode_avg_rating(%s, %s)"
            cursor.execute(
                stmt,
                (
                    podcast_id,
                    episode_num,
                ),
            )
            result = cursor.fetchone()
            if not result:
                return HTTPException(
                    status_code=404, detail="Failed to get episode ratings"
                )
            return {
                "globalEpisodeAvgRating": list(result.values())[0],
            }
    except pymysql.err.OperationalError as e:
        error_code, message = e.args
        raise HTTPException(status_code=400, detail=message)


@router.get("/{episode_num}/ratings/{user_id}")
async def getEpisodeDerivedRatings(podcast_id: int, episode_num: int, user_id: int):
    try:
        with db_cursor() as cursor:
            stmt = "SELECT get_user_friends_episode_avg_rating(%s, %s, %s)"
            cursor.execute(
                stmt,
                (
                    user_id,
                    podcast_id,
                    episode_num,
                ),
            )
            result = cursor.fetchone()
            if not result:
                return HTTPException(
                    status_code=404,
                    detail="Failed to get episode ratings from a user's friends",
                )
            return {
                "friendsEpisodeAvgRating": list(result.values())[0],
            }
    except pymysql.err.OperationalError as e:
        error_code, message = e.args
        raise HTTPException(status_code=400, detail=message)
