import { useContext, useEffect, useState } from "react";
import { useParams } from "react-router-dom";
import { LoginContext } from "../contexts/LoginContext";

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

type FriendReviews = {
  id: string;
  rating: string;
  comment: string;
  createdAt: string;
  username: string;
  firstName: string;
  lastName: string;
};

const API_URL_BASE = import.meta.env.VITE_API_URL;

export default function Podcast() {
  const podcastID = useParams().podcastID;
  const { loggedIn, userID } = useContext(LoginContext);
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

  const [friendReviews, setFriendReviews] = useState("");

  useEffect(() => {
    if (!userID) return;

    setRatings((prevRatings) => ({ ...prevRatings, friendsAvgRating: "", friendsAvgRatingByEp: "" }));
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

    async function fetchFriendReviews() {
      try {
        const response = await fetch(`${API_URL_BASE}/podcasts/${podcastID}/reviews/${userID}/friends`);
        const data = await response.json();
        // console.log(data);
      } catch (error) {
        console.log("Failed to fetch user's friends podcast reviews");
      }
    }

    async function fetchPodcastInfo() {
      try {
        const response = await fetch(`${API_URL_BASE}/podcasts/${podcastID}`);
        const data = await response.json();
        setPodcastInfo({
          name: data.name,
          description: data.description,
          releaseDate: data.release_date,
        });
      } catch (error) {
        console.log(`Failed to fetch podcast info`, error);
      }
    }

    fetchPodcastInfo();
    fetchPodcastRatings();
    fetchFriendReviews();
  }, [loggedIn]);

  // useEffect(() => {
  //   console.log(ratings);
  //   console.log(podcastInfo);
  // }, [ratings, podcastInfo]);

  return <h1>podcast page</h1>;
}
