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
  first_name: string;
  last_name: string;
  podcast_id: string;
  episode_num: string;
  rating: string;
  comment: string;
  created_at: string;
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
    <div className="min-h-screen bg-background scheme-dark">
      {loggedIn ? (
        <div className="flex flex-col px-15 gap-5">
          <Label className="text-xl font-bold mb-5">Your feed</Label>
          {feed.length > 0 ? (
            feed.map((review) => (
              <Card>
                <CardHeader>
                  <CardTitle>{review.first_name} rated</CardTitle>
                </CardHeader>
                <CardContent></CardContent>
              </Card>
            ))
          ) : (
            <div>Build a feed by following your friends!</div>
          )}
        </div>
      ) : (
        <div>Create an account or log in to see a feed</div>
      )}
    </div>
  );
}
