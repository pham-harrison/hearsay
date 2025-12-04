import { useEffect, useState } from "react";
import { useLocation, useNavigate } from "react-router-dom";
import PodcastCard from "../components/PodcastCard";
import UserCard from "../components/UserCard";
import {
  Item,
  ItemActions,
  ItemContent,
  ItemDescription,
  ItemFooter,
  ItemHeader,
  ItemMedia,
  ItemTitle,
} from "@/components/ui/item";
import { faFaceSadCry } from "@fortawesome/free-solid-svg-icons";
import { FontAwesomeIcon } from "@fortawesome/react-fontawesome";
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
  firstName: string;
  lastName: string;
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
        // console.log(data);
        setResults(data);
      } catch (error) {
        console.error("Failed to fetch search results", error);
      }
    }
    fetchResults();
  }, [location.search]);

  useEffect(() => {
    console.log(results);
  }, [results]);

  return (
    <>
      {searchType === "podcasts" && results.length > 0 && (
        <div className="flex flex-col gap-5 px-5 py-5">
          {(results as PodcastResults[]).map((podcast) => (
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
        </div>
      )}

      {searchType === "podcasts" && results.length == 0 && (
        <div className="flex-1 flex items-center justify-center">
          <Item>
            <ItemContent>
              <ItemTitle>
                <FontAwesomeIcon icon={faFaceSadCry} className="text-4xl" />
                <div>
                  <p className="text-xl font-semibold">No results found</p>
                  <p
                    className="hover:underline cursor-pointer font-normal"
                    onClick={() =>
                      window.open(
                        "https://docs.google.com/forms/d/e/1FAIpQLSfV9lHMmpNd7XZ-wUyiDy-UzGeW6dY3SfwYePnqc4js97h6mQ/viewform?usp=header"
                      )
                    }
                  >
                    Report missing?
                  </p>
                </div>
              </ItemTitle>
            </ItemContent>
          </Item>
        </div>
      )}

      {searchType === "users" && results.length > 0 && (
        <div className="grid md:grid-cols-5 ml-30 mr-30 gap-5 my-5">
          {(results as UserResults[]).map((user) => (
            <UserCard
              key={user.id}
              username={user.username}
              bio={user.bio}
              onClick={() => navigate(`/users/${user.id}`)}
            />
          ))}
        </div>
      )}

      {searchType === "users" && results.length == 0 && (
        <div className="flex-1 flex items-center justify-center">
          <Item>
            <ItemContent>
              <ItemTitle>
                <FontAwesomeIcon icon={faFaceSadCry} className="text-4xl" />
                <p className="text-xl font-semibold">No users found</p>
              </ItemTitle>
            </ItemContent>
          </Item>
        </div>
      )}
    </>
  );
}
