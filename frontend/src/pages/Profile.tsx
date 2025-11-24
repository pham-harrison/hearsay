import { useParams } from "react-router-dom";

type Friend = {
  id: number;
  date_added: Date;
  username: string;
  first_name: string;
  last_name: string;
};

type Playlist = {
  name: string;
  description: string;
};

const API_URL_BASE = import.meta.env.VITE_API_URL;

export default function Profile() {
  const userID = useParams().userID;
  async function getUserInfo() {
    // Profile data
    const u_response: Response = await fetch(`${API_URL_BASE}/users/${userID}`);
    const profileData = await u_response.json();
    console.log(`profile data:`);
    console.log(profileData);
    // Friends data (Delete friends)
    const f_response: Response = await fetch(
      `${API_URL_BASE}/users/${userID}/friends`
    );
    const friendsData = await f_response.json();
    console.log(`friends:`);
    console.log(friendsData);
    // Playlist data (Create, Delete playlist)
    const pl_response: Response = await fetch(
      `${API_URL_BASE}/users/${userID}/playlists`
    );
    const playlistData = await pl_response.json();
    console.log(`playlists:`);
    console.log(playlistData);
    // Episode data (Add, Delete)
    const e_response = await playlistData.map(async (playlist: Playlist) => {
      const ep = await fetch(
        `${API_URL_BASE}/users/${userID}/playlists/${playlist.name}/episodes`
      );
      const epData = await ep.json();
      console.log("episode:");
      console.log(epData);
    });
  }
  getUserInfo();
  return (
    <>
      <h1>Profile page</h1>;
    </>
  );
}
