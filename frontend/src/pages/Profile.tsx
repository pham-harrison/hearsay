import { useParams } from "react-router-dom";
import { useState, useEffect, useContext } from "react";
import { LoginContext } from "../contexts/LoginContext";
import Friends from "./Friends";
import Playlists from "./Playlists";

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
        <h1>{profile.username}</h1>
      </div>
      <div>Friends list</div>
      <Friends />
      <div>Playlists</div>
      <Playlists />
    </>
  );
}
