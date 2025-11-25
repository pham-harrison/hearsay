import { useParams } from "react-router-dom";
import { useState, useEffect, useContext } from "react";
import { LoginContext } from "../contexts/LoginContext";
import avatar from "../assets/avatar.png";
import Friends from "./Friends";
import Playlists from "./Playlists";
import Reviews from "./Reviews";

type displayType = "reviews" | "playlists";

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
  const [displayType, setDisplayType] = useState<displayType>("reviews");
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
  }, [loggedIn]);
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
        onChange={(e) => setDisplayType(e.target.value as displayType)}
      >
        <option value={"Reviews"}>Reviews</option>
        <option value={"Playlists"}>Playlists</option>
      </select>
      <div>Playlists</div>
      <Playlists />
      <div>Reviews</div>
    </>
  );
}
