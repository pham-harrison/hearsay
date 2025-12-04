from fastapi import APIRouter, HTTPException, Depends
from typing import Optional
from ..db import db_cursor
from pydantic import BaseModel
from .episodes import router as episodes_router
from .reviews import router as reviews_router
import pymysql
from ..utils.convertSnakeToCamel import convertListKeyToCamel, convertDictKeyToCamel


class Review(BaseModel):
    rating: int
    comment: str


router = APIRouter(prefix="/podcasts")
router.include_router(episodes_router, prefix="/{podcast_id}/episodes")
router.include_router(reviews_router, prefix="/{podcast_id}/reviews")


# Search for a podcast
@router.get("/")
async def searchPodcasts(
    name: Optional[str] = None,
    genre: Optional[str] = None,
    language: Optional[str] = None,
    platform: Optional[str] = None,
    host: Optional[str] = None,
    guest: Optional[str] = None,
    year: Optional[int] = None,
):
    try:
        with db_cursor() as cursor:
            host_first_name, host_last_name = None, None
            if host:
                host_name_parts = host.split()
                if len(host_name_parts) > 1:
                    host_last_name = host_name_parts[1]
                host_first_name = host_name_parts[0]

            guest_first_name, guest_last_name = None, None
            if guest:
                guest_name_parts = guest.split()
                if len(guest_name_parts) > 1:
                    guest_last_name = guest_name_parts[1]
                guest_first_name = guest_name_parts[0]

            cursor.callproc(
                "search_podcasts",
                (
                    name,
                    genre,
                    language,
                    platform,
                    host_first_name,
                    host_last_name,
                    guest_first_name,
                    guest_last_name,
                    year,
                ),
            )
            return convertListKeyToCamel(cursor.fetchall())
    except pymysql.err.OperationalError as e:
        error_code, message = e.args
        raise HTTPException(status_code=400, detail=message)


@router.get("/filters")
async def getFilters():
    try:
        with db_cursor() as cursor:
            filters = {}

            cursor.callproc("get_all_genres")
            genre_rows = cursor.fetchall()
            genres = [f"{row["genre_name"]}" for row in genre_rows]
            filters["genres"] = genres

            cursor.callproc("get_all_languages")
            language_rows = cursor.fetchall()
            languages = [f"{row["language_name"]}" for row in language_rows]
            filters["languages"] = languages

            cursor.callproc("get_all_platforms")
            platform_rows = cursor.fetchall()
            platforms = [f"{row["platform_name"]}" for row in platform_rows]
            filters["platforms"] = platforms

            cursor.callproc("get_all_hosts")
            host_rows = cursor.fetchall()
            hosts = [f"{row['first_name']} {row['last_name']}" for row in host_rows]
            filters["hosts"] = hosts

            cursor.callproc("get_all_guests")
            guest_rows = cursor.fetchall()
            guests = [f"{row["first_name"]} {row["last_name"]}" for row in guest_rows]
            filters["guests"] = guests

            return filters
    except pymysql.err.OperationalError as e:
        error_code, message = e.args
        raise HTTPException(status_code=400, detail=message)


# Get info about a podcast
@router.get("/{podcast_id}")
async def getPodcast(podcast_id: int):
    try:
        with db_cursor() as cursor:
            cursor.callproc("get_podcast", (podcast_id,))
            result = cursor.fetchone()
            if not result:
                return HTTPException(status_code=404, detail="User review not found")
            return convertDictKeyToCamel(result)
    except pymysql.err.OperationalError as e:
        error_code, message = e.args
        raise HTTPException(status_code=400, detail=message)


# Get all derived podcast ratings
@router.get("/{podcast_id}/ratings")
async def getPodcastGlobalRatings(podcast_id: int):
    try:
        with db_cursor() as cursor:
            stmt = "SELECT get_global_podcast_avg_rating(%s)"
            cursor.execute(stmt, (podcast_id,))
            global_avg_rating = cursor.fetchone()

            stmt = "SELECT get_global_podcast_avg_rating_by_episode(%s)"
            cursor.execute(stmt, (podcast_id,))
            global_avg_rating_by_ep = cursor.fetchone()

            return {
                "globalAvgRating": list(global_avg_rating.values())[0],
                "globalAvgRatingByEp": list(global_avg_rating_by_ep.values())[0],
            }
    except pymysql.err.OperationalError as e:
        error_code, message = e.args
        raise HTTPException(status_code=400, detail=message)


# Get all derived podcast friend ratings for a user's friends
@router.get("/{podcast_id}/ratings/{user_id}/friends")
async def getPodcastUserFriendsRatings(podcast_id: int, user_id: int):
    try:
        with db_cursor() as cursor:
            stmt = "SELECT get_user_friends_podcast_avg_rating(%s, %s)"
            cursor.execute(
                stmt,
                (
                    user_id,
                    podcast_id,
                ),
            )
            friends_avg_rating = cursor.fetchone()

            stmt = "SELECT get_user_friends_podcast_avg_rating_by_episode(%s, %s)"
            cursor.execute(
                stmt,
                (
                    user_id,
                    podcast_id,
                ),
            )
            friends_avg_rating_by_ep = cursor.fetchone()
            return {
                "friendsAvgRating": list(friends_avg_rating.values())[0],
                "friendsAvgRatingByEp": list(friends_avg_rating_by_ep.values())[0],
            }
    except pymysql.err.OperationalError as e:
        error_code, message = e.args
        raise HTTPException(status_code=400, detail=message)
