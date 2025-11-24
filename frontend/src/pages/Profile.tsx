import { useParams } from "react-router-dom";

type Friend = {
  id: string;
  date_added: string;
  username: string;
  first_name: string;
  last_name: string;
};

type Playlist = {
  name: string;
  description: string;
};

type Episode = {
  podcast_id: string;
  episode_num: string;
};

const API_URL_BASE = import.meta.env.VITE_API_URL;

export default function Profile() {
  const userID = useParams().userID;
  async function getUserInfo() {
    // Profile data
    const u_response: Response = await fetch(`${API_URL_BASE}/users/${userID}`);
    const profileData = await u_response.json();

    // Friends data (Delete friends)
    const f_response: Response = await fetch(
      `${API_URL_BASE}/users/${userID}/friends`
    );
    const allFriendsData = await f_response.json();

    // Individual friend data
    const friendsData = await Promise.all(
      allFriendsData.map(async (friend: Friend) => {
        const fr_response: Response = await fetch(
          `${API_URL_BASE}/users/${friend.id}`
        );
        const friendData = await fr_response.json();
        return friendData;
      })
    );

    // Playlist data (Create, Delete playlist)
    const pl_response: Response = await fetch(
      `${API_URL_BASE}/users/${userID}/playlists`
    );
    const playlistData = await pl_response.json();

    // Episode data (Add, Delete)
    const episodesData = await Promise.all(
      playlistData.map(async (playlist: Playlist) => {
        const e_response: Response = await fetch(
          `${API_URL_BASE}/users/${userID}/playlists/${playlist.name}/episodes`
        );
        const epData: Episode = await e_response.json();
        return epData;
      })
    );
    // log out data
    console.log(`profile data:`);
    console.log(profileData);
    console.log(`friends:`);
    console.log(friendsData);
    console.log(`friend details:`);
    console.log(friendsData);
    console.log(`playlists:`);
    console.log(playlistData);
    console.log("episodes");
    console.log(episodesData);
  }
  getUserInfo();
  return (
    <>
      <div>
        <h1>Profile page</h1>
      </div>
      <div>Friends list</div>
      <div>Playlists</div>
      <div></div>
    </>
  );
}
