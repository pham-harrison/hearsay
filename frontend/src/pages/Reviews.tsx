import { useParams, useNavigate } from "react-router-dom";
import { useState, useEffect, useContext } from "react";
import ReviewCard from "../components/PlaylistCard";
import { LoginContext } from "../contexts/LoginContext";

type Review = {
  rating: string;
  comment: string;
  created_at: string;
};

const API_URL_BASE = import.meta.env.VITE_API_URL;
export default function Reviews() {
  const { loggedIn } = useContext(LoginContext);
  const urlID = useParams().userID;
  const [results, setResults] = useState<Review[]>([]);

  useEffect(() => {
    async function getUserReviews() {
      const response: Response = await fetch(
        `${API_URL_BASE}/users/${urlID}/reviews`
      );
      const data = await response.json();
      setResults(data);
    }
    getUserReviews();
  }, [loggedIn]);
  return (
    <div>
      {(results as Review[]).map((review) => (
        <ReviewCard
          key={review.rating}
          name={review.comment}
          description={review.created_at}
          onClick={() => {}}
        />
      ))}
    </div>
  );
}
