from fastapi import APIRouter, HTTPException
from typing import Optional
from ..db import db_cursor
from pydantic import BaseModel
import pymysql

router = APIRouter()

class PlaylistEp(BaseModel):
    podcast_id: int
    episode_num: int

# Get all playlists for a user
@router.get("/")
async def getPlaylist(user_id: int):
    try:
        with db_cursor() as cursor:
            cursor.callproc("get_playlists", (user_id,))
            return cursor.fetchall()
    except pymysql.err.OperationalError as e:
        error_code, message = e.args
        raise HTTPException(status_code=400, detail=message)
    
# Create a playlist for a user
@router.post("/{playlist_name}", status_code=201)
async def createPlaylist(user_id: int, playlist_name: str):
    try:
        with db_cursor() as cursor:
            cursor.callproc("create_playlist", (user_id, playlist_name))
            return {"playlistCreated": True, "message": "New playlist created successfully", "playlist_name": playlist_name}
    except pymysql.err.OperationalError as e:
        error_code, message = e.args
        raise HTTPException(status_code=400, detail=message)

# Delete a playlist for a user
@router.delete("/{playlist_name}")
async def deletePlaylist(user_id: int, playlist_name: str):
    try:
        with db_cursor() as cursor:
            cursor.callproc("delete_playlist", (user_id, playlist_name,))
            return {"playlistDelete": True, "message": "Playlist deleted successfully", "playlist_name": playlist_name}
    except pymysql.err.OperationalError as e:
        error_code, message = e.args
        raise HTTPException(status_code=400, detail=message)

# Get all episodes for a playlist
@router.get("/{playlist_name}/episodes")
async def createPlaylist(user_id: int, playlist_name: str):
    try:
        with db_cursor() as cursor:
            cursor.callproc("get_episodes_in_playlist", (user_id, playlist_name))
            return cursor.fetchall()
    except pymysql.err.OperationalError as e:
        error_code, message = e.args
        raise HTTPException(status_code=400, detail=message)

# Add an episode to a playlist
@router.post("/{playlist_name}/episodes", status_code=201)
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
@router.delete("/{playlist_name}/episodes")
async def removeFromPlaylist(user_id: int, playlist_name: str, playlist_ep: PlaylistEp):
    try:
        with db_cursor() as cursor:
            cursor.callproc("remove_episode_from_playlist", (user_id, playlist_ep.podcast_id, playlist_ep.episode_num, playlist_name))
            return {"playlistEpisodeDeleted": True,
                 "message": "Episode deleted from playlist successfully", "playlist_name": playlist_name}
    except pymysql.err.OperationalError as e:
        error_code, message = e.args
        raise HTTPException(status_code=400, detail=message)