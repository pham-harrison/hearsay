from fastapi import APIRouter, HTTPException, Depends
from ..db import db_cursor
from .auth import getCurrentUser
from pydantic import BaseModel
from ..utils.convertSnakeToCamel import convertListKeyToCamel, convertDictKeyToCamel

import pymysql

router = APIRouter()


class PlaylistCreate(BaseModel):
    description: str


class EpisodeInfo(BaseModel):
    podcastId: int
    episodeNum: int


# Get all playlists for a user
@router.get("/")
async def getPlaylist(user_id: int):
    try:
        with db_cursor() as cursor:
            cursor.callproc("get_playlists", (user_id,))
            return convertListKeyToCamel(cursor.fetchall())
    except pymysql.err.OperationalError as e:
        error_code, message = e.args
        raise HTTPException(status_code=400, detail=message)


# Create a playlist for a user
@router.post("/{playlist_name}", status_code=201)
async def createPlaylist(
    user_id: int,
    playlist_name: str,
    body: PlaylistCreate,
    current_user: int = Depends(getCurrentUser),
):
    if user_id != current_user:
        raise HTTPException(
            status_code=400, detail="Unauthorized to make changes to user"
        )
    try:
        with db_cursor() as cursor:
            cursor.callproc(
                "create_playlist", (user_id, playlist_name, body.description)
            )
            return {
                "playlistCreated": True,
                "message": "New playlist created successfully",
                "playlist_name": playlist_name,
            }

    except pymysql.err.OperationalError as e:
        error_code, message = e.args
        raise HTTPException(status_code=400, detail=message)
    except pymysql.err.IntegrityError:
        raise HTTPException(status_code=400, detail="Playlist already exists")


# Delete a playlist for a user
@router.delete("/{playlist_name}")
async def deletePlaylist(
    user_id: int, playlist_name: str, current_user: int = Depends(getCurrentUser)
):
    if user_id != current_user:
        raise HTTPException(
            status_code=400, detail="Unauthorized to make changes to user"
        )
    try:
        with db_cursor() as cursor:
            cursor.callproc(
                "delete_playlist",
                (
                    user_id,
                    playlist_name,
                ),
            )
            return {
                "playlistDelete": True,
                "message": "Playlist deleted successfully",
                "playlist_name": playlist_name,
            }
    except pymysql.err.OperationalError as e:
        error_code, message = e.args
        raise HTTPException(status_code=400, detail=message)


# Get all episodes for a playlist
@router.get("/{playlist_name}/episodes")
async def createPlaylist(user_id: int, playlist_name: str):
    try:
        with db_cursor() as cursor:
            cursor.callproc("get_episodes_in_playlist", (user_id, playlist_name))
            return convertListKeyToCamel(cursor.fetchall())
    except pymysql.err.OperationalError as e:
        error_code, message = e.args
        raise HTTPException(status_code=400, detail=message)


# Add an episode to a playlist
@router.post("/{playlist_name}/episodes", status_code=201)
async def addToPlaylist(
    user_id: int,
    playlist_name: str,
    episode_info: EpisodeInfo,
    current_user: int = Depends(getCurrentUser),
):
    if user_id != current_user:
        raise HTTPException(
            status_code=400, detail="Unauthorized to make changes to user"
        )
    try:
        with db_cursor() as cursor:
            cursor.callproc(
                "add_episode_to_playlist",
                (
                    user_id,
                    episode_info.podcastId,
                    episode_info.episodeNum,
                    playlist_name,
                ),
            )
            return {
                "playlistEpisodeAdded": True,
                "message": "New episode added to playlist successfully",
                "playlist_name": playlist_name,
            }
    except pymysql.err.OperationalError as e:
        error_code, message = e.args
        raise HTTPException(status_code=400, detail=message)
    except pymysql.err.IntegrityError:
        raise HTTPException(status_code=400, detail="Episode already in playlist")


# Remove an episode from a playlist
@router.delete("/{playlist_name}/episodes")
async def removeFromPlaylist(
    user_id: int,
    playlist_name: str,
    episode_info: EpisodeInfo,
    current_user: int = Depends(getCurrentUser),
):
    if user_id != current_user:
        raise HTTPException(
            status_code=400, detail="Unauthorized to make changes to user"
        )
    try:
        with db_cursor() as cursor:
            cursor.callproc(
                "remove_episode_from_playlist",
                (
                    user_id,
                    episode_info.podcastId,
                    episode_info.episodeNum,
                    playlist_name,
                ),
            )
            return {
                "playlistEpisodeDeleted": True,
                "message": "Episode deleted from playlist successfully",
                "playlist_name": playlist_name,
            }
    except pymysql.err.OperationalError as e:
        error_code, message = e.args
        raise HTTPException(status_code=400, detail=message)
