import { useState, useEffect, useContext } from "react";
import { LoginContext } from "../contexts/LogInContext";

type friendReview = {
  userID: string;
  username: string;
  first_name: string;
  last_name: string;
  podcast_id: string;
  episode_num: string;
  rating: string;
  comment: string;
  created_at: string;
};

const API_URL_BASE = import.meta.env.VITE_API_URL;

export default function Home() {
  const { loggedIn, userID } = useContext(LoginContext);
  const [feed, setFeed] = useState<friendReview[]>([]);

  useEffect(() => {
    if (!loggedIn) return;

    async function getFeed() {
      const response: Response = await fetch(`${API_URL_BASE}/users/${userID}/feed`);
      const data = await response.json();
      console.log(data);
      setFeed(data);
    }
    getFeed();
  }, [loggedIn]);

  return (
    <>
      {loggedIn ? (
        <div>
          Your feed
          {feed.length > 0 ? (
            <ul>
              {feed.map((review) => (
                <li>
                  {review.first_name} rated {review.episode_num} a {review.rating} and said {review.comment}
                </li>
              ))}
            </ul>
          ) : (
            <div>Build a feed by following your friends!</div>
          )}
        </div>
      ) : (
        <div>Create an account or log in to see a feed</div>
      )}
    </>
  );
}
