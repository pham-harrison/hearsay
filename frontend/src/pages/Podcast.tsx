import { useContext, useEffect, useState } from "react";
import { useParams } from "react-router-dom";
import { LoginContext } from "../contexts/LoginContext";
import SearchBar from "@/components/SearchBar";
type ActiveModal = "createReview" | "updateReview" | "episode" | null;

type PodcastInfo = {
  name: string;
  description: string;
  releaseDate: string;
};

type PodcastRatings = {
  globalAvgRating: string;
  globalAvgRatingByEp: string;
  friendsAvgRating: string;
  friendsAvgRatingByEp: string;
};

type FriendReview = {
  id: string;
  rating: string;
  comment: string;
  createdAt: string;
  username: string;
  firstName: string;
  lastName: string;
};

type UserReview = {
  rating: string;
  comment: string;
  createdAt: string;
};

const API_URL_BASE = import.meta.env.VITE_API_URL;

export default function Podcast() {
  const podcastID = useParams().podcastID;
  const { loggedIn, userID, token } = useContext(LoginContext);
  const [podcastInfo, setPodcastInfo] = useState<PodcastInfo>({
    name: "",
    description: "",
    releaseDate: "",
  });

  const [ratings, setRatings] = useState<PodcastRatings>({
    globalAvgRating: "",
    globalAvgRatingByEp: "",
    friendsAvgRating: "",
    friendsAvgRatingByEp: "",
  });

  const [friendReviews, setFriendReviews] = useState<FriendReview[]>([]);
  const [userReview, setUserReview] = useState<UserReview | null>(null);
  const [formReview, setFormReview] = useState<{
    rating: string;
    comment: string;
  }>({ rating: "", comment: "" });
  const [activeModal, setActiveModal] = useState<ActiveModal>(null);

  useEffect(() => {
    if (!userID) return;
    setRatings((prevRatings) => ({
      ...prevRatings,
      friendsAvgRating: "",
      friendsAvgRatingByEp: "",
    }));
    setUserReview(null);
    setFriendReviews([]);

    async function fetchFriendReviews() {
      if (!loggedIn) return;
      try {
        const response = await fetch(`${API_URL_BASE}/podcasts/${podcastID}/reviews/${userID}/friends`);
        const data = await response.json();
        setFriendReviews(data);
      } catch (error) {
        console.log("Failed to fetch user's friends podcast reviews", error);
      }
    }

    async function fetchPodcastInfo() {
      try {
        const response = await fetch(`${API_URL_BASE}/podcasts/${podcastID}`);
        const data = await response.json();
        setPodcastInfo(data);
      } catch (error) {
        console.log(`Failed to fetch podcast info`, error);
      }
    }

    async function getUserPodcastReview() {
      if (!loggedIn) return;
      try {
        const response = await fetch(`${API_URL_BASE}/podcasts/${podcastID}/reviews/${userID}`);
        const data: UserReview = await response.json();
        if (data) {
          setFormReview({ rating: data.rating, comment: data.comment });
          setUserReview(data);
        }
      } catch (error) {
        console.log("Failed to fetch user's podcast review", error);
      }
    }

    fetchPodcastInfo();
    fetchPodcastRatings();
    fetchFriendReviews();
    getUserPodcastReview();
  }, [loggedIn]);

  async function fetchPodcastRatings() {
    try {
      let response = await fetch(`${API_URL_BASE}/podcasts/${podcastID}/ratings`);
      let data = await response.json();
      setRatings((prevRatings) => ({
        ...prevRatings,
        globalAvgRating: data.global_avg_rating,
        globalAvgRatingByEp: data.global_avg_rating_by_ep,
      }));
      if (loggedIn) {
        response = await fetch(`${API_URL_BASE}/podcasts/${podcastID}/ratings/${userID}`);
        data = await response.json();
        setRatings((prevRatings) => ({
          ...prevRatings,
          friendsAvgRating: data.friends_avg_rating,
          friendsAvgRatingByEp: data.friends_avg_rating_by_ep,
        }));
      }
    } catch (error) {
      console.log(`Failed to fetch podcast ratings`, error);
    }
  }

  async function handleCreateReview(e: React.FormEvent) {
    e.preventDefault();
    if (!formReview.rating) {
      alert("Every review needs a rating!");
      return;
    }

    try {
      const response = await fetch(`${API_URL_BASE}/podcasts/${podcastID}/reviews/${userID}`, {
        method: "POST",
        headers: {
          "Content-Type": "application/json",
          Authorization: `Bearer ${token}`,
        },
        body: JSON.stringify({
          rating: formReview.rating,
          comment: formReview.comment,
        }),
      });
      const data = await response.json();
      if (!response.ok) {
        alert(data.detail);
        return;
      }
      setActiveModal(null);
      setUserReview({
        rating: formReview.rating,
        comment: formReview.comment,
        createdAt: Date.now().toString(),
      });
      fetchPodcastRatings();
    } catch (error) {
      console.log("Failed to insert the user's podcast review", error);
    }
  }

  async function handleUpdateReview(e: React.FormEvent) {
    e.preventDefault();
    if (!formReview.rating) {
      alert("Every review needs a rating!");
      return;
    }
    try {
      const response = await fetch(`${API_URL_BASE}/podcasts/${podcastID}/reviews/${userID}`, {
        method: "PUT",
        headers: {
          "Content-Type": "application/json",
          Authorization: `Bearer ${token}`,
        },
        body: JSON.stringify({
          rating: formReview.rating,
          comment: formReview.comment,
        }),
      });
      const data = await response.json();
      if (!response.ok) {
        alert(data.detail);
        return;
      }
      setActiveModal(null);
      setUserReview({
        rating: formReview.rating,
        comment: formReview.comment,
        createdAt: Date.now().toString(),
      });
      fetchPodcastRatings();
    } catch (error) {
      console.log("Failed to update user's podcast review", error);
    }
  }

  async function handleDeleteReview() {
    try {
      const response = await fetch(`${API_URL_BASE}/podcasts/${podcastID}/reviews/${userID}`, {
        method: "DELETE",
        headers: {
          "Content-Type": "application/json",
          Authorization: `Bearer ${token}`,
        },
      });
      const data = await response.json();
      if (!response.ok) {
        console.log(data.detail);
      }
      setActiveModal(null);
      setUserReview(null);
      setFormReview({ rating: "", comment: "" });
    } catch (error) {
      console.log("Failed to delete the user's podcast review", error);
    }
  }

  return (
    <>
      <h1>podcast page</h1>
      {loggedIn && userReview ? (
        <button onClick={() => setActiveModal("updateReview")}>Update review</button>
      ) : (
        <button disabled={!loggedIn} onClick={() => setActiveModal("createReview")}>
          Review
        </button>
      )}
      {activeModal === "createReview" && (
        <div className="fixed bg-purple-300 top-1/2 left-1/2 transform -translate-x-1/2 -translate-y-1/2">
          <form className="flex flex-col" onSubmit={(e) => handleCreateReview(e)}>
            <label>Rating</label>
            <input type="number" onChange={(e) => setFormReview({ ...formReview, rating: e.target.value })}></input>
            <label>Comment</label>
            <input type="text" onChange={(e) => setFormReview({ ...formReview, comment: e.target.value })}></input>
            <button type="submit">Submit</button>
          </form>
        </div>
      )}

      {activeModal === "updateReview" && (
        <div className="fixed bg-purple-300 top-1/2 left-1/2 transform -translate-x-1/2 -translate-y-1/2">
          <div>Written on {userReview?.createdAt}</div>
          <form className="flex flex-col" onSubmit={(e) => handleUpdateReview(e)}>
            <label>Rating</label>
            <input
              type="number"
              value={formReview.rating}
              onChange={(e) => setFormReview({ ...formReview, rating: e.target.value })}
            ></input>
            <label>Comment</label>
            <input
              type="text"
              value={formReview.comment}
              onChange={(e) => setFormReview({ ...formReview, comment: e.target.value })}
            ></input>
            <button type="submit">Update</button>
            <button type="button" onClick={handleDeleteReview}>
              Delete review
            </button>
          </form>
        </div>
      )}
      <SearchBar
        searchType="episodes"
        onSearch={async (searchFilters) => {
          const params = new URLSearchParams();
          Object.entries(searchFilters).forEach(([filter, value]) => {
            if (value) params.append(filter, value);
          });
          const response = await fetch(`${API_URL_BASE}/podcasts/${podcastID}/episodes?${params.toString()}`);
          const data = await response.json();
          console.log(data);
        }}
        podcastID={podcastID}
      ></SearchBar>
    </>
  );
}
