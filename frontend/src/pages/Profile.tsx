import { useParams } from "react-router-dom";
import { useState, useEffect, useContext } from "react";
import { LoginContext } from "../contexts/LoginContext";
import avatar from "../assets/avatar.png";
import Friends from "./Friends";
import Playlists from "./Playlists";
import Reviews from "./Reviews";

type DisplayType = "reviews" | "playlists";

type User = {
  id: string;
  username: string;
  first_name: string;
  last_name: string;
  bio: string;
};

type Playlist = {
  name: string;
  description: string;
};

type activeModal = "create" | null;

const API_URL_BASE = import.meta.env.VITE_API_URL;

export default function Profile() {
  const { loggedIn, userID, token } = useContext(LoginContext);
  const [profile, setProfile] = useState<User>([]);
  const [displayType, setDisplayType] = useState<DisplayType>("reviews");
  const [activeModal, setActiveModal] = useState<activeModal>(null);
  const [playlistName, setPlaylistName] = useState<string>("");
  const [playlistDesc, setPlaylistDesc] = useState<string>("");
  const [playlists, setPlaylists] = useState<Playlist[]>([]);
  const urlID = useParams().userID;

  console.log("Papa playlist: ", playlists);

  useEffect(() => {
    async function getUserInfo() {
      // Profile data
      const u_response: Response = await fetch(
        `${API_URL_BASE}/users/${urlID}`
      );
      const profileData: User = await u_response.json();
      setProfile(profileData);
    }
    // Playlist data
    async function getUserPlaylists() {
      const response: Response = await fetch(
        `${API_URL_BASE}/users/${urlID}/playlists`
      );
      const data = await response.json();
      setPlaylists(data);
    }

    getUserInfo();
    getUserPlaylists();
  }, [urlID, loggedIn, userID]);

  async function handlePlaylistCreate(e: React.FormEvent) {
    e.preventDefault();
    if (!playlistName) {
      alert("Please enter a playlist name");
      return;
    }
    try {
      const response = await fetch(
        `${API_URL_BASE}/users/${userID}/playlists/${playlistName}`,
        {
          method: "POST",
          headers: {
            "Content-Type": "application/json",
            Authorization: `Bearer ${token}`,
          },
          body: JSON.stringify({ description: playlistDesc }),
        }
      );
      if (!response.ok) {
        console.error("Response not ok from create playlist");
      } else {
        const newPlaylist: Playlist = {
          name: playlistName,
          description: playlistDesc,
        };
        setPlaylists((prev) => [...prev, newPlaylist]);
      }
    } catch (error) {
      console.error("Failed to create playlist", error);
    }
  }

  async function handlePlaylistDelete(playlist: string) {
    try {
      const response = await fetch(
        `${API_URL_BASE}/users/${urlID}/playlists/${playlist}`,
        {
          method: "DELETE",
          headers: {
            "Content-Type": "application/json",
            Authorization: `Bearer ${token}`,
          },
        }
      );
      if (!response.ok) {
        console.error("Response from delete playlist not ok");
      } else {
        setPlaylists((prev) => prev.filter((pl) => pl.name !== playlist));
      }
    } catch (error) {
      console.error("Failed to delete playlist", error);
    }
  }

  return (
    <>
      <div>
        <img src={avatar} className="w-48 h-48"></img>
        <h1>{profile.username}</h1>
      </div>
      <div>Friends list</div>
      <Friends />

      <select
        value={displayType}
        onChange={(e) => setDisplayType(e.target.value as DisplayType)}
      >
        <option value={"reviews"}>Reviews</option>
        <option value={"playlists"}>Playlists</option>
      </select>
      {loggedIn && userID === urlID && displayType === "playlists" && (
        <button
          className="bg-green-500 hover:bg-green-700 text-white font-bold py-2 px-4 rounded"
          onClick={
            activeModal === null
              ? () => setActiveModal("create")
              : () => setActiveModal(null)
          }
        >
          Create
        </button>
      )}
      {displayType === "reviews" && <Reviews />}
      {displayType === "playlists" && (
        <Playlists
          playlists={playlists}
          onPlaylistDelete={handlePlaylistDelete}
        />
      )}
      {activeModal === "create" && (
        <div className="bg-yellow-200 fixed top-1/2 left-1/2 transform -translate-x-1/2 -translate-y-1/2">
          <form className="flex flex-col" onSubmit={handlePlaylistCreate}>
            <label>Name of new playlist</label>
            <input
              type="text"
              onChange={(e) => setPlaylistName(e.target.value)}
              placeholder="Title..."
            ></input>
            <input
              type="text"
              onChange={(e) => setPlaylistDesc(e.target.value)}
              placeholder="Description..."
            ></input>
            <button
              type="submit"
              className="bg-green-500 hover:bg-green-700 text-white font-bold py-2 px-4 rounded"
            >
              Confirm
            </button>
          </form>
        </div>
      )}
    </>
  );
}
