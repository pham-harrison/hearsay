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

const API_URL_BASE = import.meta.env.VITE_API_URL;

export default function Profile() {
  const { loggedIn, userID } = useContext(LoginContext);
  const [profile, setProfile] = useState<User>([]);
  const [displayType, setDisplayType] = useState<DisplayType>("reviews");
  const urlID = useParams().userID;

  useEffect(() => {
    async function getUserInfo() {
      // Profile data
      const u_response: Response = await fetch(
        `${API_URL_BASE}/users/${urlID}`
      );
      const profileData: User = await u_response.json();
      setProfile(profileData);
    }

    getUserInfo();
  }, [urlID, userID]);
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
      {displayType === "reviews" && <Reviews />}
      {displayType === "playlists" && <Playlists />}
    </>
  );
}
