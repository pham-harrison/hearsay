from fastapi import APIRouter, HTTPException, Depends
from typing import Optional
from ..db import db_cursor
from .auth import getCurrentUser
from pydantic import BaseModel
import pymysql


class Review(BaseModel):
    rating: int
    comment: str


router = APIRouter()


# Create a podcast review
@router.post("/{user_id}", status_code=201)
async def addReviewPodcast(user_id: int, podcast_id: int, review: Review, current_user: int = Depends(getCurrentUser)):
    if current_user != user_id:
        raise HTTPException(
            status_code=400, detail="Unauthorized to make changes to user"
        )
    try:
        with db_cursor() as cursor:
            cursor.callproc(
                "insert_podcast_review",
                (user_id, podcast_id, review.rating, review.comment),
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


# Get a podcast review
@router.get("/{user_id}")
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
@router.put("/{user_id}")
async def updateReviewPodcast(user_id: int, podcast_id: int, review: Review, current_user: int = Depends(getCurrentUser)):
    if current_user != user_id:
        raise HTTPException(
            status_code=400, detail="Unauthorized to make changes to user"
        )
    try:
        with db_cursor() as cursor:
            cursor.callproc(
                "update_podcast_review",
                (user_id, podcast_id, review.rating, review.comment),
            )
            return {
                "reviewAdded": True,
                "message": "Review updated successfully",
                "rating": review.rating,
                "comment": review.comment,
            }
    except pymysql.err.OperationalError as e:
        error_code, message = e.args
        raise HTTPException(status_code=400, detail=message)


# Delete a podcast review
@router.delete("/{user_id}")
async def deleteUserPodcastReview(podcast_id: int, user_id: int, current_user: int = Depends(getCurrentUser)):
    if current_user != user_id:
        raise HTTPException(
            status_code=400, detail="Unauthorized to make changes to user"
        )
    try:
        with db_cursor() as cursor:
            cursor.callproc(
                "delete_podcast_review",
                (
                    user_id,
                    podcast_id,
                ),
            )
            return {"reviewDelete": True, "message": "Review deleted successfully"}
    except pymysql.err.OperationalError as e:
        error_code, message = e.args
        raise HTTPException(status_code=400, detail=message)


# Get all friend reviews of a podcast
@router.get("/{user_id}/friends")
async def getAllFriendsReviewsPodcast(podcast_id: int, user_id: int):
    try:
        with db_cursor() as cursor:
            cursor.callproc(
                "get_user_friends_podcast_reviews",
                (
                    user_id,
                    podcast_id,
                ),
            )
            return cursor.fetchall()
    except pymysql.err.OperationalError as e:
        error_code, message = e.args
        raise HTTPException(status_code=400, detail=message)
