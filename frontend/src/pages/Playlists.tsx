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

type PlaylistProps = {
  playlists: Playlist[];
  onPlaylistDelete: (name: string) => void;
};

const API_URL_BASE = import.meta.env.VITE_API_URL;

export default function Playlists({
  playlists,
  onPlaylistDelete,
}: PlaylistProps) {
  const { loggedIn, userID, token } = useContext(LoginContext);
  const urlID = useParams().userID;
  const navigate = useNavigate();
  const [episodesByPlaylist, setEpisodesByPlaylist] = useState<
    Record<string, Episode[]>
  >({});
  const [expandedPlaylists, setExpandedPlaylists] = useState<Set<string>>(
    new Set()
  );
  const [refreshOnDelete, setRefreshOnDelete] = useState(0);

  useEffect(() => {}, [urlID, loggedIn, userID, refreshOnDelete]);

  // Episode data
  async function getEpisodes(playlist: string) {
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

  async function handleEpisodeDelete(
    playlist: string,
    podcast_id: string,
    episode_num: string
  ) {
    try {
      const response = await fetch(
        `${API_URL_BASE}/users/${urlID}/playlists/${playlist}/episodes`,
        {
          method: "DELETE",
          headers: {
            "Content-Type": "application/json",
            Authorization: `Bearer ${token}`,
          },
          body: JSON.stringify({ podcast_id, episode_num }),
        }
      );
      if (!response.ok) {
        console.error("Response from delete episode from playlist not ok");
      } else {
        getEpisodes(playlist);
        setRefreshOnDelete(() => {
          return refreshOnDelete + 1;
        });
      }
    } catch (error) {
      console.error("Failed to delete episode from playlist", error);
    }
  }

  function isOpen(playlist: string) {
    return expandedPlaylists.has(playlist);
  }

  return (
    <>
      <div>
        {playlists.map((playlist) => {
          const episodes = episodesByPlaylist[playlist.name] ?? [];
          return (
            <div key={playlist.name}>
              <PlaylistCard
                name={playlist.name}
                description={playlist.description}
                onClick={() => {
                  handlePlaylistClick(playlist.name);
                }}
                onDelete={() => {
                  onPlaylistDelete(playlist.name);
                }}
              />
              {loggedIn && userID === urlID && (
                <button
                  className="bg-red-500 hover:bg-red-700 text-white font-bold py-2 px-4 rounded"
                  onClick={(e) => {
                    e.stopPropagation();
                    onPlaylistDelete(playlist.name);
                  }}
                >
                  Delete Playlist
                </button>
              )}
              {(episodes as Episode[]).map(
                (episode) =>
                  isOpen(playlist.name) && (
                    <ul key={episode.podcast_id + episode.episode_num}>
                      <EpisodeCard
                        podcast_id={episode.podcast_id}
                        podcast_name={episode.podcast_name}
                        episode_num={episode.episode_num}
                        onClick={() =>
                          navigate(
                            `/podcasts/${episode.podcast_id}/episodes/${episode.episode_num}`
                          )
                        }
                        onDelete={() => {
                          handleEpisodeDelete(
                            playlist.name,
                            episode.podcast_id,
                            episode.episode_num
                          );
                        }}
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
