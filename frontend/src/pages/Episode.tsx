import { useContext, useEffect, useState } from "react";
import { useParams, useNavigate } from "react-router-dom";
import { LoginContext } from "../contexts/LoginContext";
import {
  Card,
  CardHeader,
  CardDescription,
  CardContent,
  CardFooter,
  CardTitle,
} from "@/components/ui/card";
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
  DialogFooter,
} from "@/components/ui/dialog";
import { Textarea } from "@/components/ui/textarea";
import { toast } from "sonner";
import {
  Carousel,
  CarouselContent,
  CarouselItem,
  CarouselNext,
  CarouselPrevious,
} from "@/components/ui/carousel";
import { RainbowButton } from "@/components/ui/rainbow-button";
import confetti from "canvas-confetti";
import PageReviewCard from "@/components/PageReviewCard";
import Autoplay from "embla-carousel-autoplay";
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
import { Input } from "@/components/ui/input";
import { Avatar, AvatarImage, AvatarFallback } from "../components/ui/avatar";
import avatar from "../assets/minimalistAvatarF.jpg";

type ActiveModal = "createReview" | "updateReview" | "playlists" | null;

type EpisodeRating = {
  globalAvgRating: string;
  friendsAvgRating: string;
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

type EpisodeInfo = {
  episodeNum: string;
  name: string;
  description: string;
  duration: string;
  releaseDate: string;
  podcastId: string;
};

type Playlist = {
  userId: string;
  name: string;
  description: string;
};

type UserReview = {
  rating: string;
  comment: string;
  createdAt: string;
};

const API_URL_BASE = import.meta.env.VITE_API_URL;

export default function Episode() {
  const podcastID = useParams().podcastID;
  const episodeNum = useParams().episodeNum;
  const { loggedIn, userID, token } = useContext(LoginContext);
  const [episodeInfo, setEpisodeInfo] = useState<EpisodeInfo>({
    episodeNum: "",
    description: "",
    duration: "",
    name: "",
    releaseDate: "",
    podcastId: "",
  });
  const [ratings, setRatings] = useState<EpisodeRating>({
    globalAvgRating: "",
    friendsAvgRating: "",
  });
  const [friendReviews, setFriendReviews] = useState<FriendReview[]>([]);
  const [playlists, setPlaylists] = useState<Playlist[]>([]);
  const [activeModal, setActiveModal] = useState<ActiveModal>(null);
  const [userReview, setUserReview] = useState<UserReview | null>(null);
  const [formReview, setFormReview] = useState<Record<string, string>>({
    rating: "",
    comment: "",
  });
  const [playlistForm, setPlaylistForm] = useState<Playlist>({
    userId: "",
    name: "",
    description: "",
  });
  const [createPlaylistPopUp, setCreatePlaylistPopUp] =
    useState<boolean>(false);
  const [reviewPopUp, setReviewPopUp] = useState<boolean>(false);
  const navigate = useNavigate();

  useEffect(() => {
    if (loggedIn) return;
    fetchEpisodeInfo();
    fetchEpisodeRatings();
    setRatings((prevRatings) => ({
      ...prevRatings,
      friendsAvgRating: "",
    }));
    setUserReview(null);
    setFriendReviews([]);
  }, []);

  useEffect(() => {
    if (!loggedIn) return;

    async function fetchFriendReviews() {
      if (!loggedIn) return;
      try {
        const response = await fetch(
          `${API_URL_BASE}/podcasts/${podcastID}/episodes/${episodeNum}/reviews/${userID}/friends`
        );
        const data = await response.json();
        setFriendReviews(data);
      } catch (error) {
        console.error("Failed to fetch user's friends episode review", error);
      }
    }

    async function fetchUserReview() {
      if (!loggedIn) return;
      try {
        const response = await fetch(
          `${API_URL_BASE}/podcasts/${podcastID}/episodes/${episodeNum}/reviews/${userID}`
        );
        const data: UserReview = await response.json();
        if (data) {
          setFormReview({ rating: data.rating, comment: data.comment });
          setUserReview(data);
        }
      } catch (error) {
        console.log("Failed to fetch user's episode review", error);
      }
    }

    fetchEpisodeInfo();
    fetchEpisodeRatings();
    fetchFriendReviews();
    fetchUserReview();
  }, [loggedIn]);

  async function fetchEpisodeInfo() {
    try {
      const response = await fetch(
        `${API_URL_BASE}/podcasts/${podcastID}/episodes/${episodeNum}`
      );
      const data = await response.json();
      setEpisodeInfo(data);
    } catch (error) {
      console.error("Failed to fetch episode info", error);
    }
  }

  async function fetchEpisodeRatings() {
    try {
      let response = await fetch(
        `${API_URL_BASE}/podcasts/${podcastID}/episodes/${episodeNum}/ratings`
      );
      let data = await response.json();
      setRatings((prevRatings) => ({
        ...prevRatings,
        globalAvgRating: data.globalEpisodeAvgRating,
      }));
      if (loggedIn) {
        response = await fetch(
          `${API_URL_BASE}/podcasts/${podcastID}/episodes/${episodeNum}/ratings/${userID}`
        );
        data = await response.json();
        setRatings((prevRatings) => ({
          ...prevRatings,
          friendsAvgRating: data.friendsEpisodeAvgRating,
        }));
      }
    } catch (error) {
      console.error("Failed to fetch episode ratings", error);
    }
  }

  async function handleCreateReview(e: React.FormEvent) {
    e.preventDefault();
    if (!formReview.rating) {
      toast.error("Every review needs a rating!");
      return;
    }

    try {
      const response = await fetch(
        `${API_URL_BASE}/podcasts/${podcastID}/episodes/${episodeNum}/reviews/${userID}`,
        {
          method: "POST",
          headers: {
            "Content-Type": "application/json",
            Authorization: `Bearer ${token}`,
          },
          body: JSON.stringify({
            rating: formReview.rating,
            comment: formReview.comment ?? "",
          }),
        }
      );
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
      setReviewPopUp(false);
      toast.success("Review Submitted!");
      confetti({
        particleCount: 125,
        spread: 180,
        startVelocity: 40,
      });
      fetchEpisodeRatings();
    } catch (error) {
      console.log("Failed to insert the user's episode review", error);
    }
  }

  async function handleUpdateReview(e: React.FormEvent) {
    e.preventDefault();
    if (!formReview.rating) {
      toast.error("Every review needs a rating!");
      return;
    }
    try {
      const response = await fetch(
        `${API_URL_BASE}/podcasts/${podcastID}/episodes/${episodeNum}/reviews/${userID}`,
        {
          method: "PUT",
          headers: {
            "Content-Type": "application/json",
            Authorization: `Bearer ${token}`,
          },
          body: JSON.stringify({
            rating: formReview.rating,
            comment: formReview.comment ?? "",
          }),
        }
      );
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
      fetchEpisodeRatings();
    } catch (error) {
      console.log("Failed to update user's episode review", error);
    }
  }

  async function handleDeleteReview() {
    try {
      const response = await fetch(
        `${API_URL_BASE}/podcasts/${podcastID}/episodes/${episodeNum}/reviews/${userID}`,
        {
          method: "DELETE",
          headers: {
            "Content-Type": "application/json",
            Authorization: `Bearer ${token}`,
          },
        }
      );
      const data = await response.json();
      if (!response.ok) {
        toast.error(data.detail);
      }
      setUserReview(null);
      setFormReview({ rating: "", comment: "" });
      toast.success("Review Deleted!");
      fetchEpisodeRatings();
    } catch (error) {
      console.log("Failed to delete the user's episode review", error);
    }
  }

  async function handlePlaylistSearch() {
    try {
      const response = await fetch(`${API_URL_BASE}/users/${userID}/playlists`);
      const data = await response.json();
      setPlaylists(data);
    } catch (error) {
      console.error("Failed to get playlists", error);
    }
  }

  async function handleAddToPlaylist(playlistName: string) {
    try {
      const response = await fetch(
        `${API_URL_BASE}/users/${userID}/playlists/${playlistName}/episodes`,
        {
          method: "POST",
          headers: {
            "Content-Type": "application/json",
            Authorization: `Bearer ${token}`,
          },
          body: JSON.stringify({
            podcastId: podcastID,
            episodeNum: episodeNum,
          }),
        }
      );
      const data = await response.json();
      if (!response.ok) {
        toast.error(data.detail);
        return;
      }
      toast.success("Episode added to playlist!");
    } catch (error) {
      console.error("Failed to add episode to playlist", error);
    }
  }

  async function handleCreatePlaylist(e: React.FormEvent) {
    e.preventDefault();
    if (playlistForm.name === "") {
      toast.error("Enter a name for your new playlist!");
      return;
    }

    try {
      const response = await fetch(
        `${API_URL_BASE}/users/${userID}/playlists/${playlistForm.name}`,
        {
          method: "POST",
          headers: {
            "Content-Type": "application/json",
            Authorization: `Bearer ${token}`,
          },
          body: JSON.stringify({ description: playlistForm.description }),
        }
      );
      const data = await response.json();
      if (!response.ok) {
        toast.error(data.detail);
        return;
      }
      toast.success("Playlist created!");
      setPlaylistForm({ userId: "", name: "", description: "" });
      setCreatePlaylistPopUp(false);
      handlePlaylistSearch();
    } catch (error) {
      console.error("Failed to add episode to playlist", error);
    }
  }

  return (
    <>
      {/* Hero */}
      <Card className="flex flex-col md:flex-row items-center md:items-start bg-linear-to-tr from-white to-purple-500 py-10 px-6 mt-5">
        <CardContent>
          <img
            src={podcast}
            className="h-50 w-50 md:h-65 md:w-65 object-cover rounded-sm shadow-lg hover:scale-98 duration-225"
          />
        </CardContent>
        <div className="flex flex-col justify-between gap-4">
          <CardTitle className="text-2xl text-purple-800">
            Episode {episodeInfo.episodeNum}
          </CardTitle>
          <CardTitle className="font-bold text-4xl md:text-5xl text-gray-900 tracking-tight">
            {episodeInfo.name}
          </CardTitle>
          <CardDescription className="text-lg text-gray-700">
            {episodeInfo.description}
          </CardDescription>
          <CardDescription className="text-sm text-gray-500">
            Released: {dateFormat(episodeInfo.releaseDate)} &nbsp; &#8226;
            &nbsp; Duration: {episodeInfo.duration} mins
          </CardDescription>
          <div>
            <Dialog>
              <DialogTrigger asChild>
                <Button
                  className="mt-7 text-md hover:scale-102 duration-150 cursor-pointer"
                  disabled={!loggedIn}
                  onClick={handlePlaylistSearch}
                >
                  + Add to Playlist
                </Button>
              </DialogTrigger>
              <DialogContent>
                <DialogHeader>
                  <DialogTitle className="mb-4">Select a Playlist</DialogTitle>
                  <DialogDescription></DialogDescription>
                  <div className="max-h-[50vh] overflow-scroll flex flex-col gap-3">
                    {playlists.map((playlist) => (
                      <Item
                        key={playlist.name}
                        className="flex justify-between"
                        variant="outline"
                      >
                        <ItemTitle className="text-md">
                          {playlist.name}
                        </ItemTitle>
                        <ItemActions>
                          <Button
                            className="text-xl w-8 h-8 bg-transparent border rounded-full cursor-pointer"
                            onClick={() => handleAddToPlaylist(playlist.name)}
                          >
                            +
                          </Button>
                        </ItemActions>
                      </Item>
                    ))}
                  </div>
                </DialogHeader>
                <DialogFooter>
                  <div className="flex justify-end">
                    <Button onClick={() => setCreatePlaylistPopUp(true)}>
                      Create New Playlist
                    </Button>
                  </div>
                </DialogFooter>
              </DialogContent>
            </Dialog>

            <Dialog
              open={createPlaylistPopUp}
              onOpenChange={setCreatePlaylistPopUp}
            >
              <DialogContent>
                <DialogHeader>
                  <DialogTitle>New Playlist</DialogTitle>
                  <DialogDescription>
                    Create your new playlist
                  </DialogDescription>
                </DialogHeader>
                <form onSubmit={handleCreatePlaylist}>
                  <DialogDescription className="font-medium mb-3">
                    Playlist Name
                  </DialogDescription>
                  <Input
                    type="text"
                    maxLength={20}
                    onChange={(e) =>
                      setPlaylistForm({ ...playlistForm, name: e.target.value })
                    }
                  ></Input>
                  <DialogDescription className="font-medium my-3">
                    Add an optional description
                  </DialogDescription>
                  <Input
                    type="text"
                    maxLength={50}
                    onChange={(e) =>
                      setPlaylistForm({
                        ...playlistForm,
                        description: e.target.value,
                      })
                    }
                  ></Input>
                  <div className="flex justify-end mt-3">
                    <Button type="submit">Create Playlist</Button>
                  </div>
                </form>
              </DialogContent>
            </Dialog>
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
                  <RainbowButton
                    className="hover:scale-102 duration-175"
                    disabled={!loggedIn}
                  >
                    Update Review
                  </RainbowButton>
                </DialogTrigger>

                <DialogContent>
                  <DialogHeader>
                    <DialogTitle className="text-xl">Update Review</DialogTitle>
                    <DialogDescription>
                      Your last review written on{" "}
                      {dateFormat(userReview.createdAt)}
                    </DialogDescription>
                  </DialogHeader>
                  <form
                    className="flex flex-col gap-5"
                    onSubmit={(e) => handleUpdateReview(e)}
                  >
                    <Label className="font-medium">Rating</Label>
                    <Rating
                      className="flex justify-center"
                      defaultValue={Number(userReview.rating)}
                      onValueChange={(value) => {
                        setFormReview({
                          ...formReview,
                          rating: value.toString(),
                        });
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
                      onChange={(e) =>
                        setFormReview({
                          ...formReview,
                          comment: e.target.value,
                        })
                      }
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
                        <Button
                          className="cursor-pointer hover:scale-102 duration-150"
                          type="submit"
                        >
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
              <Dialog open={reviewPopUp} onOpenChange={setReviewPopUp}>
                <DialogTrigger asChild>
                  <RainbowButton
                    className="hover:scale-102 duration-175"
                    disabled={!loggedIn}
                  >
                    Review
                  </RainbowButton>
                </DialogTrigger>
                <DialogContent>
                  <DialogHeader>
                    <DialogTitle className="text-xl">Review</DialogTitle>
                    <DialogDescription>
                      What do you think of this podcast?
                    </DialogDescription>
                  </DialogHeader>
                  <form
                    className="flex flex-col gap-5"
                    onSubmit={(e) => handleCreateReview(e)}
                  >
                    <Label className="font-medium">Rating</Label>
                    <Rating
                      className="flex justify-center"
                      onValueChange={(value) => {
                        setFormReview({
                          ...formReview,
                          rating: value.toString(),
                        });
                      }}
                    >
                      {Array.from({ length: 5 }).map((_, i) => (
                        <RatingButton key={i} size={32} />
                      ))}
                    </Rating>
                    <Label className="font-medium">Comment</Label>
                    <Textarea
                      placeholder="Add an optional comment"
                      onChange={(e) =>
                        setFormReview({
                          ...formReview,
                          comment: e.target.value,
                        })
                      }
                    />
                    <div className="flex justify-end">
                      <Button
                        type="submit"
                        className="self-start cursor-pointer hover:scale-102 duration-150"
                      >
                        Submit
                      </Button>
                    </div>
                  </form>
                </DialogContent>
              </Dialog>
            </div>
          )}
        </div>

        <CardContent className="grid grid-cols-1 md:grid-cols-2 gap-4 px-5">
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
              <p className="text-md font-medium text-center">
                What your friends think
              </p>
              <div className="flex flex-row items-center gap-2">
                <p className="text-3xl font-bold">{ratings.friendsAvgRating}</p>
                <FontAwesomeIcon icon={faStar} className="text-xl" />
              </div>
            </CardContent>
          </Card>
        </CardContent>
      </Card>

      <Card className="flex flex-col bg-background border-none shadow-none px-5">
        <CardTitle className="text-xl font-bold">
          Reviews From Your Friends
        </CardTitle>
        <CardContent>
          {!loggedIn && (
            <div className="flex justify-center items-center">
              <Card className="w-100 text-center justify-center h-35">
                <CardHeader>
                  <CardTitle>No reviews</CardTitle>
                  <CardDescription>
                    Create an account or log in to see what your friends think
                  </CardDescription>
                </CardHeader>
              </Card>
            </div>
          )}

          {loggedIn && friendReviews.length < 1 && (
            <div className="flex justify-center items-center">
              <Card className="w-100 text-center justify-center h-35">
                <CardHeader>
                  <CardTitle>No reviews</CardTitle>
                  <CardDescription>
                    No friends have rated this episode yet
                  </CardDescription>
                </CardHeader>
              </Card>
            </div>
          )}

          {loggedIn && friendReviews.length > 0 && (
            <div className="flex flex-col gap-4">
              {friendReviews.map((review) => (
                <PageReviewCard
                  id={review.id}
                  rating={review.rating}
                  comment={review.comment}
                  createdAt={review.createdAt}
                  username={review.username}
                  firstName={review.firstName}
                  lastName={review.lastName}
                  width="w-full"
                />
              ))}
            </div>
          )}
        </CardContent>
      </Card>
    </>
  );
}
