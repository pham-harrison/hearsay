import { useContext, useEffect, useState } from "react";
import { useParams } from "react-router-dom";
import { LoginContext } from "../contexts/LoginContext";
import SearchBar from "@/components/SearchBar";
import { Card, CardHeader, CardDescription, CardContent, CardFooter, CardTitle } from "@/components/ui/card";
import { Button } from "@/components/ui/button";
import podcast from "../assets/minimalistMicrophone.jpg";
import dateFormat from "@/utils/dateFormat";
import { faStar, faEyeSlash, faTrash } from "@fortawesome/free-solid-svg-icons";
import { FontAwesomeIcon } from "@fortawesome/react-fontawesome";
import { Label } from "@radix-ui/react-label";
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
import { Textarea } from "@/components/ui/textarea";
import { toast } from "sonner";
import { Carousel, CarouselContent, CarouselItem, CarouselNext, CarouselPrevious } from "@/components/ui/carousel";
import { RainbowButton } from "@/components/ui/rainbow-button";
import confetti from "canvas-confetti";
import PageReviewCard from "@/components/PageReviewCard";
import Autoplay from "embla-carousel-autoplay";

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
  const [genreList, setGenreList] = useState<string[]>([]);
  const [openReview, setOpenReview] = useState<boolean>(false);

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
        console.log(data);
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

  useEffect(() => {
    if (podcastInfo.genres) {
      setGenreList(podcastInfo.genres.split(","));
    }
  }, [podcastInfo]);

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
        toast.error(data.detail);
        return;
      }
      setUserReview({
        rating: formReview.rating,
        comment: formReview.comment,
        createdAt: new Date().toISOString().split("T")[0],
      });
      setOpenReview(false);
      toast.success("Review Submitted!");
      confetti({
        particleCount: 125,
        spread: 180,
        startVelocity: 40,
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
        toast.error(data.detail);
        return;
      }
      setUserReview({
        rating: formReview.rating,
        comment: formReview.comment,
        createdAt: new Date().toISOString().split("T")[0],
      });
      toast.success("Review Updated!");
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
      setUserReview(null);
      setFormReview({ rating: "", comment: "" });
      toast.success("Review Deleted!");
      fetchPodcastRatings();
    } catch (error) {
      console.log("Failed to delete the user's podcast review", error);
    }
  }

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
              <div className="flex flex-row gap-2">
                {genreList &&
                  genreList.map((genre) => (
                    <Button
                      key={genre}
                      className="text-sm px-3 py-1 rounded-full bg-purple-300 text-purple-800 hover:bg-purple-300 hover:text-purple-800 hover:scale-98 duration-150"
                    >
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
          {loggedIn && userReview?.rating ? (
            <div>
              <Dialog>
                <DialogTrigger asChild>
                  <RainbowButton className="hover:scale-102 duration-175" disabled={!loggedIn}>
                    Update Review
                  </RainbowButton>
                </DialogTrigger>

                <DialogContent>
                  <DialogHeader>
                    <DialogTitle className="text-xl">Update Review</DialogTitle>
                    <DialogDescription>
                      Your last review written on {dateFormat(userReview.createdAt)}
                    </DialogDescription>
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
                    <Textarea
                      value={formReview.comment}
                      placeholder="Add an optional comment"
                      onChange={(e) => setFormReview({ ...formReview, comment: e.target.value })}
                    ></Textarea>
                    <div className="flex flex-row items-center justify-between">
                      <DialogClose asChild>
                        <Button
                          type="button"
                          className="cursor-pointer hover:scale-102 duration-150"
                          onClick={handleDeleteReview}
                        >
                          <FontAwesomeIcon icon={faTrash} />
                        </Button>
                      </DialogClose>
                      <DialogClose asChild>
                        <Button className="cursor-pointer hover:scale-102 duration-150" type="submit">
                          Update
                        </Button>
                      </DialogClose>
                    </div>
                  </form>
                </DialogContent>
              </Dialog>
            </div>
          ) : (
            <div className="flex justify-end">
              <Dialog open={openReview} onOpenChange={setOpenReview}>
                <DialogTrigger asChild>
                  <RainbowButton className="hover:scale-102 duration-175" disabled={!loggedIn}>
                    Review
                  </RainbowButton>
                </DialogTrigger>
                <DialogContent>
                  <DialogHeader>
                    <DialogTitle className="text-xl">Review</DialogTitle>
                    <DialogDescription>What do you think of this podcast?</DialogDescription>
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
                    <Textarea
                      placeholder="Add an optional comment"
                      onChange={(e) => setFormReview({ ...formReview, comment: e.target.value })}
                    />
                    <div className="flex justify-end">
                      <Button type="submit" className="self-start cursor-pointer hover:scale-102 duration-150">
                        Submit
                      </Button>
                    </div>
                  </form>
                </DialogContent>
              </Dialog>
            </div>
          )}
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

      <Card className="flex flex-col bg-background border-none shadow-none px-5">
        <CardTitle className="text-xl font-bold">Reviews From Your Friends</CardTitle>
        <CardContent>
          {friendReviews.length > 0 ? (
            <Carousel
              opts={{
                loop: true,
              }}
              plugins={[
                Autoplay({
                  delay: 2000,
                  stopOnMouseEnter: true,
                }),
              ]}
            >
              <CarouselContent className="-ml-4 my-3 xl:-ml-31">
                {friendReviews.map((review, index) => (
                  <CarouselItem key={index} className="xl:pl-35 md:basis-1/2 lg:basis-1/3 xl:basis-1/4">
                    <PageReviewCard
                      id={review.id}
                      rating={review.rating}
                      comment={review.comment}
                      createdAt={review.createdAt}
                      username={review.username}
                      firstName={review.firstName}
                      lastName={review.lastName}
                    />
                  </CarouselItem>
                ))}
              </CarouselContent>
              <CarouselPrevious className="left-0 hover:bg-primary! hover:text-white! cursor-pointer" />
              <CarouselNext className="right-0 hover:bg-primary! hover:text-white! cursor-pointer" />
            </Carousel>
          ) : (
            <div className="flex justify-center items-center">
              <Card className="w-100 text-center">
                <CardHeader>
                  <CardTitle>No reviews</CardTitle>
                  <CardDescription>No friends have reviewed this podcast yet</CardDescription>
                </CardHeader>
              </Card>
            </div>
          )}
        </CardContent>
      </Card>

      {/* Search episodes */}
      <Card className="flex flex-col items-center mt-5 rounded-sm">
        <CardHeader>
          <CardTitle className="text-nowrap -translate-x-1/2 text-3xl font-bold">Search Episodes</CardTitle>
        </CardHeader>
        <CardContent>
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
        </CardContent>
      </Card>

      <div className="mb-1000"></div>
    </>
  );
}
