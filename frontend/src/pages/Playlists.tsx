import { useParams, useNavigate } from "react-router-dom";
import { useState, useEffect, useContext } from "react";
import PlaylistCard from "../components/PlaylistCard";
import { LoginContext } from "../contexts/LoginContext";
import EpisodeCard from "../components/EpisodeCard";

type Playlist = {
  name: string;
  description: string;
};

type Episode = {
  podcast_id: string;
  podcast_name: string;
  episode_num: string;
};

const API_URL_BASE = import.meta.env.VITE_API_URL;

export default function Playlists() {
  const { loggedIn, userID } = useContext(LoginContext);
  const urlID = useParams().userID;
  const navigate = useNavigate();

  const [playlists, setPlaylists] = useState<Playlist[]>([]);
  const [episodesByPlaylist, setEpisodesByPlaylist] = useState<
    Record<string, Episode[]>
  >({});
  const [expandedPlaylists, setExpandedPlaylists] = useState<Set<string>>(
    new Set()
  );

  useEffect(() => {
    async function getUserPlaylists() {
      // Playlist data (Create, Delete playlist, Add Ep, Delete Ep)
      const response: Response = await fetch(
        `${API_URL_BASE}/users/${urlID}/playlists`
      );
      const data = await response.json();
      setPlaylists(data);
    }
    getUserPlaylists();
  }, [urlID, userID]);

  // Episode data
  async function getEpisodes(playlist: string) {
    if (episodesByPlaylist[playlist]) return;
    const response = await fetch(
      `${API_URL_BASE}/users/${urlID}/playlists/${playlist}/episodes`
    );
    const data = await response.json();
    setEpisodesByPlaylist((prev) => {
      const next = { ...prev, [playlist]: data };
      return next;
    });
  }

  async function handlePlaylistClick(playlist: string) {
    getEpisodes(playlist);
    setExpandedPlaylists((prev) => {
      const next = new Set(prev);
      if (next.has(playlist)) {
        next.delete(playlist);
      } else {
        next.add(playlist);
      }
      return next;
    });
  }

  function isOpen(playlist: string) {
    return expandedPlaylists.has(playlist);
  }

  return (
    <>
      <div>
        {(playlists as Playlist[]).map((playlist) => {
          const episodes = episodesByPlaylist[playlist.name] ?? [];
          return (
            <div key={playlist.name}>
              <PlaylistCard
                name={playlist.name}
                description={playlist.description}
                onClick={() => {
                  handlePlaylistClick(playlist.name);
                }}
              />
              {(episodes as Episode[]).map(
                (episode) =>
                  isOpen(playlist.name) && (
                    <ul>
                      <EpisodeCard
                        key={episode.episode_num}
                        podcast_id={episode.podcast_id}
                        podcast_name={episode.podcast_name}
                        episode_num={episode.episode_num}
                        onClick={() =>
                          navigate(
                            `/podcasts/${episode.podcast_id}/episodes/${episode.episode_num}`
                          )
                        }
                      />
                    </ul>
                  )
              )}
            </div>
          );
        })}
      </div>
    </>
  );
}
