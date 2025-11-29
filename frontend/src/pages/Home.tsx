import { useState, useEffect, useContext } from "react";
import { LoginContext } from "../contexts/LoginContext";
import {
  Card,
  CardAction,
  CardContent,
  CardDescription,
  CardFooter,
  CardHeader,
  CardTitle,
} from "@/components/ui/card";
import ReviewCard from "@/components/ReviewCard";

type FriendReview = {
  comment: string;
  createdAt: string;
  episodeName: string;
  episodeNum: string;
  firstName: string;
  id: string;
  lastName: string;
  podcastId: string;
  podcastName: string;
  rating: string;
  username: string;
};

const API_URL_BASE = import.meta.env.VITE_API_URL;

export default function Home() {
  const { loggedIn, userID } = useContext(LoginContext);
  const [feed, setFeed] = useState<FriendReview[]>([]);

  useEffect(() => {
    if (!loggedIn) return;

    async function getFeed() {
      const response: Response = await fetch(`${API_URL_BASE}/users/${userID}/feed`);
      const data = await response.json();
      setFeed(data);
    }
    getFeed();
  }, [loggedIn]);

  return (
    <div className="bg-background">
      {loggedIn ? (
        <div className="flex flex-col px-15 gap-5">
          <CardHeader>
            <CardTitle className="text-xl font-bold mt-5">Your feed</CardTitle>
          </CardHeader>
          {feed.length > 0 ? (
            // <div className="grid lg:grid-cols-3 md:grid-cols-2 gap-5 justify-items-center">
            <div className="flex flex-row flex-wrap gap-5 justify-center">
              {feed.map((review: FriendReview, i) => (
                <ReviewCard
                  key={i}
                  review={{
                    id: review.id,
                    username: review.username,
                    firstName: review.firstName,
                    lastName: review.lastName,
                    podcastId: review.podcastId,
                    podcastName: review.podcastName,
                    rating: review.rating,
                    comment: review.comment,
                    createdAt: review.createdAt,
                    onClick: () => {},
                    type: "episode",
                    episodeNum: review.episodeNum,
                    episodeName: review.episodeName,
                  }}
                />
              ))}
            </div>
          ) : (
            <div className="flex justify-center items-center min-h-screen">
              <Card className="w-100 text-center">
                <CardHeader>
                  <CardTitle>Welcome!</CardTitle>
                  <CardDescription>
                    Add your friends to see a personalized feed of your friends' activity
                  </CardDescription>
                </CardHeader>
              </Card>
            </div>
          )}
        </div>
      ) : (
        <div className="flex justify-center items-center min-h-screen">
          <Card className="w-100 text-center">
            <CardHeader>
              <CardTitle className="text-lg">No feed yet</CardTitle>
              <CardDescription>
                Create an account or log in to see a personalized feed of your friends' activity
              </CardDescription>
            </CardHeader>
          </Card>
        </div>
      )}
    </div>
  );
}
