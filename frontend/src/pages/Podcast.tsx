import { useContext, useEffect, useState } from "react";
import { useParams } from "react-router-dom";
import { LoginContext } from "../contexts/LoginContext";
import SearchBar from "@/components/SearchBar";
import { Card, CardHeader, CardContent, CardFooter, CardTitle } from "@/components/ui/card";
import { Button } from "@/components/ui/button";
import podcast from "../assets/minimalistMicrophone.jpg";
import dateFormat from "@/utils/dateFormat";
import { faStar, faEyeSlash } from "@fortawesome/free-solid-svg-icons";
import { FontAwesomeIcon } from "@fortawesome/react-fontawesome";
import { Label } from "@radix-ui/react-label";
import { Input } from "@/components/ui/input";
import { Rating, RatingButton } from "@/components/ui/shadcn-io/rating";
import {
  Dialog,
  DialogContent,
  DialogDescription,
  DialogHeader,
  DialogTitle,
  DialogTrigger,
  DialogClose,
} from "@/components/ui/dialog";
import { toast } from "sonner";

type ActiveModal = "createReview" | "updateReview" | "episode" | null;

type PodcastInfo = {
  name: string;
  description: string;
  releaseDate: string;
  genres: string;
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
    genres: "",
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
  const [genreList, setGenreList] = useState<string[]>([]);

  useEffect(() => {
    if (loggedIn) return;
    fetchPodcastInfo();
    fetchPodcastRatings();
    setRatings((prevRatings) => ({
      ...prevRatings,
      friendsAvgRating: "",
      friendsAvgRatingByEp: "",
    }));
    setUserReview(null);
    setFriendReviews([]);
  }, []);

  useEffect(() => {
    if (!loggedIn) return;

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

    fetchPodcastInfo();
    fetchPodcastRatings();
    fetchFriendReviews();
    getUserPodcastReview();
  }, [loggedIn]);

  async function fetchPodcastInfo() {
    try {
      const response = await fetch(`${API_URL_BASE}/podcasts/${podcastID}`);
      const data = await response.json();
      setPodcastInfo(data);
    } catch (error) {
      console.log(`Failed to fetch podcast info`, error);
    }
  }

  async function fetchPodcastRatings() {
    try {
      let response = await fetch(`${API_URL_BASE}/podcasts/${podcastID}/ratings`);
      let data: PodcastRatings = await response.json();
      setRatings((prevRatings) => ({
        ...prevRatings,
        globalAvgRating: data.globalAvgRating,
        globalAvgRatingByEp: data.globalAvgRatingByEp,
      }));
      if (loggedIn) {
        response = await fetch(`${API_URL_BASE}/podcasts/${podcastID}/ratings/${userID}/friends`);
        data = await response.json();
        setRatings((prevRatings) => ({
          ...prevRatings,
          friendsAvgRating: data.friendsAvgRating,
          friendsAvgRatingByEp: data.friendsAvgRatingByEp,
        }));
      }
    } catch (error) {
      console.log(`Failed to fetch podcast ratings`, error);
    }
  }

  async function handleCreateReview(e: React.FormEvent) {
    e.preventDefault();
    if (!formReview.rating) {
      toast.error("Every review needs a rating!");
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
          comment: formReview.comment ?? "",
        }),
      });
      const data = await response.json();
      if (!response.ok) {
        alert(data.detail);
        console.log(data);
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
    console.log("test");
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
        toast.error(data.detail);
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
      fetchPodcastRatings();
    } catch (error) {
      console.log("Failed to delete the user's podcast review", error);
    }
  }

  useEffect(() => {
    setGenreList(podcastInfo.genres.split(","));
  }, [podcastInfo]);

  return (
    <>
      {/* Hero */}
      <Card className="bg-linear-to-br from-fuchsia-300 to-purple-800 p-6 rounded-sm mt-5">
        <div className="grid md:grid-cols-2 gap-5">
          <div className="flex flex-col justify-end gap-3">
            <CardHeader className="text-5xl md:text-6xl font-extrabold tracking-tight text-gray-900">
              {podcastInfo.name}
            </CardHeader>
            <CardContent className="text-gray-700 text-lg md:text-xl">{podcastInfo.description}</CardContent>
            <CardFooter className="flex flex-row justify-between items-center">
              <span className="text-gray-700 text-sm">Released: {dateFormat(podcastInfo.releaseDate)}</span>
              <div className="flex flex-row gap-1">
                {genreList &&
                  genreList.map((genre) => (
                    <Button className="text-sm px-3 py-1 rounded-full bg-purple-300 text-purple-800 hover:bg-purple-300 hover:text-purple-800 hover:scale-98 duration-150">
                      {genre}
                    </Button>
                  ))}
              </div>
            </CardFooter>
          </div>
          <div className="h-80">
            <img
              src={podcast}
              alt={podcastInfo.name}
              className="w-full h-full object-cover rounded-sm shadow-lg hover:scale-98 duration-300"
            />
          </div>
        </div>
      </Card>

      {/* Ratings */}
      <Card className="flex flex-col bg-background border-none shadow-none px-5">
        <div className="flex flex-row justify-between">
          <CardTitle className="text-xl font-bold">Ratings</CardTitle>
          <Button>Review</Button>
        </div>
        <CardContent className="grid grid-cols-1 md:grid-cols-2 lg:grid-cols-4 gap-4 px-5">
          <Card className="hover:scale-98 duration-300 hover:shadow-lg">
            <CardContent className="flex flex-col items-center justify-center h-20 gap-3">
              <p className="text-md font-medium text-center">Average Rating</p>
              <div className="flex flex-row items-center gap-2">
                <p className="text-3xl font-bold">{ratings.globalAvgRating}</p>
                <FontAwesomeIcon icon={faStar} className="text-xl" />
              </div>
            </CardContent>
          </Card>

          <Card className="hover:scale-98 duration-300 hover:shadow-lg">
            <CardContent className="flex flex-col items-center justify-center h-20 gap-3">
              <p className="text-md font-medium text-center">Average Episode Rating</p>
              <div className="flex flex-row items-center gap-2">
                <p className="text-3xl font-bold">{ratings.globalAvgRatingByEp}</p>
                <FontAwesomeIcon icon={faStar} className="text-xl" />
              </div>
            </CardContent>
          </Card>

          <Card className="hover:scale-98 duration-300 hover:shadow-lg">
            <CardContent className="flex flex-col items-center justify-center h-20 gap-3">
              <p className="text-md font-medium text-center">What Your Friends Think</p>
              <div className="flex flex-row items-center gap-2">
                {!loggedIn ? (
                  <FontAwesomeIcon icon={faEyeSlash} className="text-xl" />
                ) : (
                  <div className="flex flex-row items-center gap-2">
                    <p className="text-3xl font-bold">{ratings.friendsAvgRating}</p>
                    <FontAwesomeIcon icon={faStar} className="text-xl" />
                  </div>
                )}
              </div>
            </CardContent>
          </Card>

          <Card className="hover:scale-98 duration-300 hover:shadow-lg">
            <CardContent className="flex flex-col items-center justify-center h-20 gap-3">
              <p className="text-md font-medium text-center">How Your Friends Rate Each Episode</p>
              <div className="flex flex-row items-center gap-2">
                {!loggedIn ? (
                  <FontAwesomeIcon icon={faEyeSlash} className="text-xl" />
                ) : (
                  <div className="flex flex-row items-center gap-2">
                    <p className="text-3xl font-bold">{ratings.friendsAvgRatingByEp}</p>
                    <FontAwesomeIcon icon={faStar} className="text-xl" />
                  </div>
                )}
              </div>
            </CardContent>
          </Card>
        </CardContent>
      </Card>

      {loggedIn && userReview?.rating ? (
        <Dialog>
          <DialogTrigger asChild>
            <Button>Update Review</Button>
          </DialogTrigger>

          <DialogContent>
            <DialogHeader>
              <DialogTitle className="text-xl">Update Review</DialogTitle>
              <DialogDescription></DialogDescription>
            </DialogHeader>
            <form className="flex flex-col gap-5" onSubmit={(e) => handleUpdateReview(e)}>
              <Label className="font-medium">Rating</Label>
              <Rating
                className="flex justify-center"
                defaultValue={Number(userReview.rating)}
                onValueChange={(value) => {
                  setFormReview({ ...formReview, rating: value.toString() });
                }}
              >
                {Array.from({ length: 5 }).map((_, i) => (
                  <RatingButton key={i} size={32} />
                ))}
              </Rating>
              <Label className="font-medium">Comment</Label>
              <Input
                type="text"
                value={formReview.comment}
                onChange={(e) => setFormReview({ ...formReview, comment: e.target.value })}
              ></Input>
              <DialogClose asChild>
                <Button type="submit">Update</Button>
              </DialogClose>
              <DialogClose asChild>
                <Button type="button" onClick={handleDeleteReview}>
                  Delete review
                </Button>
              </DialogClose>
            </form>
          </DialogContent>
        </Dialog>
      ) : (
        <Dialog>
          <DialogTrigger asChild>
            <Button disabled={!loggedIn}>Review</Button>
          </DialogTrigger>
          <DialogContent>
            <DialogHeader>
              <DialogTitle className="text-xl">Review</DialogTitle>
              <DialogDescription></DialogDescription>
            </DialogHeader>
            <form className="flex flex-col gap-5" onSubmit={(e) => handleCreateReview(e)}>
              <Label className="font-medium">Rating</Label>
              <Rating
                className="flex justify-center"
                onValueChange={(value) => {
                  setFormReview({ ...formReview, rating: value.toString() });
                }}
              >
                {Array.from({ length: 5 }).map((_, i) => (
                  <RatingButton key={i} size={32} />
                ))}
              </Rating>
              <Label className="font-medium">Comment</Label>
              <Input type="text" onChange={(e) => setFormReview({ ...formReview, comment: e.target.value })} />
              <DialogClose>
                <Button type="submit">Submit</Button>
              </DialogClose>
            </form>
          </DialogContent>
        </Dialog>
      )}

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
      <div className="mb-1000"></div>
    </>
  );
}
