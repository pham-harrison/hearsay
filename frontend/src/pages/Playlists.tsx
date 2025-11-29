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
  podcastId: string;
  podcastName: string;
  episodeNum: string;
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
  // General
  const { loggedIn, userID, token } = useContext(LoginContext);
  const urlID = useParams().userID;
  const navigate = useNavigate();
  const [refreshOnDelete, setRefreshOnDelete] = useState(0);
  // Playlist states
  const [episodesByPlaylist, setEpisodesByPlaylist] = useState<
    Record<string, Episode[]>
  >({});
  const [expandedPlaylists, setExpandedPlaylists] = useState<Set<string>>(
    new Set()
  );

  useEffect(() => {}, [urlID, loggedIn, userID, refreshOnDelete]);

  // Episode data
  async function getEpisodes(playlist: string) {
    const response = await fetch(
      `${API_URL_BASE}/users/${urlID}/playlists/${playlist}/episodes`
    );
    const data = await response.json();
    setEpisodesByPlaylist((prev) => {
      const next = { ...prev, [playlist]: data };
      console.log(next);
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
                    <ul key={episode.podcastId + episode.episodeNum}>
                      <EpisodeCard
                        podcastId={episode.podcastId}
                        podcastName={episode.podcastName}
                        episodeNum={episode.episodeNum}
                        onClick={() =>
                          navigate(
                            `/podcasts/${episode.podcastId}/episodes/${episode.episodeNum}`
                          )
                        }
                        onDelete={() => {
                          handleEpisodeDelete(
                            playlist.name,
                            episode.podcastId,
                            episode.episodeNum
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
