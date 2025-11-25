import { useParams, useNavigate } from "react-router-dom";
import { useState, useEffect, useContext } from "react";
import PlaylistCard from "../components/PlaylistCard";

type Playlist = {
  name: string;
  description: string;
};

type Episode = {
  podcast_id: string;
  episode_num: string;
};
const API_URL_BASE = import.meta.env.VITE_API_URL;

export default function Playlists() {
  const userID = useParams().userID;
  const [results, setResults] = useState<Playlist[]>([]);

  useEffect(() => {
    async function getUserPlaylists() {
      // Playlist data (Create, Delete playlist, Add Ep, Delete Ep)
      const pl_response: Response = await fetch(
        `${API_URL_BASE}/users/${userID}/playlists`
      );
      const allPlaylistData = await pl_response.json();
      setResults(allPlaylistData);
    }

    async function getPlaylistEpisodes(playlist: Playlist) {
      // Episode data
      const response = await fetch(
        `${API_URL_BASE}/users/${userID}/playlists/${playlist.name}/episodes`
      );
      const data: Episode = await response.json();
      return data;
    }
    getUserPlaylists();
  });
  return (
    <div>
      {(results as Playlist[]).map((playlist) => (
        <PlaylistCard
          key={playlist.name}
          name={playlist.name}
          description={playlist.description}
          onClick={() => {}}
        />
      ))}
    </div>
  );
}
