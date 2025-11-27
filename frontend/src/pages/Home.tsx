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
import { Label } from "@/components/ui/label";

type friendReview = {
  userID: string;
  username: string;
  firstName: string;
  lastName: string;
  podcastId: string;
  episodeNum: string;
  rating: string;
  comment: string;
  createdAt: string;
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
    <div className="bg-background">
      {loggedIn ? (
        <div className="flex flex-col px-15 gap-5">
          <Label className="text-xl font-bold mb-5">Your feed</Label>
          {feed.length > 0 ? (
            feed.map((review) => (
              <Card>
                <CardHeader>
                  <CardTitle>{review.firstName} rated</CardTitle>
                </CardHeader>
                <CardContent></CardContent>
              </Card>
            ))
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
