import { useEffect, useState } from "react";
import { useLocation, useNavigate } from "react-router-dom";
import PodcastCard from "../components/PodcastCard";
import UserCard from "../components/UserCard";
const API_URL_BASE = import.meta.env.VITE_API_URL;

type PodcastResults = {
  podcastId: string;
  name: string;
  description: string;
  releaseDate: string;
  genres: string;
};

type UserResults = {
  id: string;
  username: string;
  first_name: string;
  last_name: string;
  bio: string;
};

export default function Results() {
  const location = useLocation();
  const navigate = useNavigate();
  const params = new URLSearchParams(location.search);
  const searchType = params.get("type");
  params.delete("type");
  const [results, setResults] = useState<PodcastResults[] | UserResults[]>([]);

  useEffect(() => {
    async function fetchResults() {
      let url = "";
      if (searchType === "podcasts") {
        url = `${API_URL_BASE}/podcasts?${params.toString()}`;
      } else {
        const username = params.get("name");
        if (!username) {
          url = `${API_URL_BASE}/users/all`;
        } else {
          url = `${API_URL_BASE}/users/username/${username}`;
        }
      }

      try {
        const response = await fetch(url);
        const data = await response.json();
        setResults(data);
      } catch (error) {
        console.error("Failed to fetch search results", error);
      }
    }
    fetchResults();
  }, [location.search]);

  return (
    <div className="flex flex-col gap-5 px-5 py-5">
      {searchType === "podcasts" &&
        (results as PodcastResults[]).map((podcast) => (
          <PodcastCard
            key={podcast.podcastId}
            podcastId={podcast.podcastId}
            name={podcast.name}
            description={podcast.description}
            releaseDate={podcast.releaseDate}
            genres={podcast.genres ?? ""}
            onClick={() => {
              navigate(`/podcasts/${podcast.podcastId}`);
            }}
          />
        ))}
      {/* {searchType === "users" &&
        (results as UserResults[]).map((user) => (
          <UserCard
            key={user.id}
            id={user.id}
            username={user.username}
            first_name={user.first_name}
            last_name={user.last_name}
            bio={user.bio}
            onClick={() => navigate(`/users/${user.id}`)}
          />
        ))} */}
    </div>
  );
}
