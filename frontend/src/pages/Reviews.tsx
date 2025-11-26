import { useParams, useNavigate } from "react-router-dom";
import { useState, useEffect, useContext } from "react";
import ReviewCard from "../components/ReviewCard";
import { LoginContext } from "../contexts/LoginContext";

type PodcastReview = {
  username: string;
  podcast_name: string;
  rating: string;
  comment: string;
  created_at: string;
};

type EpisodeReview = PodcastReview & {
  episode_num: string;
};

const API_URL_BASE = import.meta.env.VITE_API_URL;
export default function Reviews() {
  const { loggedIn, userID } = useContext(LoginContext);
  const urlID = useParams().userID;
  const [podcastReviews, setPodcastReviews] = useState<PodcastReview[]>([]);
  const [episodeReviews, setEpisodeReviews] = useState<EpisodeReview[]>([]);

  useEffect(() => {
    async function getUserPodcastReviews() {
      const response: Response = await fetch(
        `${API_URL_BASE}/users/${urlID}/reviews/podcasts`
      );
      const data = await response.json();
      setPodcastReviews(data);
    }
    async function getUserEpisodeReviews() {
      const response: Response = await fetch(
        `${API_URL_BASE}/users/${urlID}/reviews/episodes`
      );
      const data = await response.json();
      setEpisodeReviews(data);
    }
    getUserPodcastReviews();
    getUserEpisodeReviews();
  }, [urlID, userID]);
  return (
    <>
      <div>
        Podcast Reviews:
        {(podcastReviews as PodcastReview[]).map((review, i) => (
          <ReviewCard
            key={i}
            review={{
              type: "podcast",
              username: review.username,
              podcast_name: review.podcast_name,
              rating: review.rating,
              comment: review.comment,
              created_at: review.created_at,
            }}
          />
        ))}
      </div>
      <div>
        Episode Reviews:
        {(episodeReviews as EpisodeReview[]).map((review, i) => (
          <ReviewCard
            key={i}
            review={{
              type: "episode",
              username: review.username,
              podcast_name: review.podcast_name,
              episode_num: review.episode_num,
              rating: review.rating,
              comment: review.comment,
              created_at: review.created_at,
            }}
          />
        ))}
      </div>
    </>
  );
}
