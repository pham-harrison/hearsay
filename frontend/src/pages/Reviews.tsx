import { useParams, useNavigate } from "react-router-dom";
import { useState, useEffect, useContext } from "react";
import ReviewCard from "../components/ReviewCard";
import { LoginContext } from "../contexts/LoginContext";

type PodcastReview = {
  id: string;
  username: string;
  firstName: string;
  lastName: string;
  podcastId: string;
  podcastName: string;
  rating: string;
  comment: string;
  createdAt: string;
  onClick: () => void;
};

type EpisodeReview = PodcastReview & {
  episodeNum: string;
  episodeName: string;
};

const API_URL_BASE = import.meta.env.VITE_API_URL;
export default function Reviews() {
  const { loggedIn, userID } = useContext(LoginContext);
  const urlID = useParams().userID;
  const navigate = useNavigate();

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
      <div className="flex justify-center gap-20 mt-4 ">
        <div className="flex flex-col justify-center gap-10 w-max-full">
          {(podcastReviews as PodcastReview[]).map((review, i) => (
            <ReviewCard
              key={i}
              review={{
                id: review.id,
                type: "podcast",
                username: review.username,
                firstName: review.firstName,
                lastName: review.lastName,
                podcastId: review.podcastId,
                podcastName: review.podcastName,
                rating: review.rating,
                comment: review.comment,
                createdAt: review.createdAt,
                onClick: () => navigate(`/users/${review.id}`),
              }}
            />
          ))}
        </div>
        <div className="flex flex-col justify-center gap-10">
          {(episodeReviews as EpisodeReview[]).map((review, i) => (
            <ReviewCard
              key={i}
              review={{
                type: "episode",
                id: review.id,
                firstName: review.firstName,
                lastName: review.lastName,
                username: review.username,
                podcastId: review.podcastId,
                podcastName: review.podcastName,
                episodeName: review.episodeName,
                episodeNum: review.episodeNum,
                rating: review.rating,
                comment: review.comment,
                createdAt: review.createdAt,
                onClick: () => {},
              }}
            />
          ))}
        </div>
      </div>
    </>
  );
}
