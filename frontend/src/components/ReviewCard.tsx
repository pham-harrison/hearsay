import {
  Card,
  CardAction,
  CardContent,
  CardDescription,
  CardFooter,
  CardHeader,
  CardTitle,
} from "@/components/ui/card";
import { Avatar, AvatarImage, AvatarFallback } from "./ui/avatar";
import avatar from "../assets/minimalistAvatarF.jpg";
import podcast from "../assets/minimalistMicrophone.jpg";
import { faStar } from "@fortawesome/free-solid-svg-icons";
import { FontAwesomeIcon } from "@fortawesome/react-fontawesome";
import { useNavigate } from "react-router-dom";
import dateFormat from "@/utils/dateFormat";

type BaseReviewProps = {
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

type PodcastReviewProps = BaseReviewProps & {
  type: "podcast";
};

type EpisodeReviewProps = BaseReviewProps & {
  type: "episode";
  episodeNum: string;
  episodeName: string;
};

type ReviewCardProps = {
  review: PodcastReviewProps | EpisodeReviewProps;
};

export default function ReviewCard({ review }: ReviewCardProps) {
  const navigate = useNavigate();
  return (
    <>
      <Card className="w-100 hover:scale-102 duration-150 shrink-0">
        <CardHeader>
          <div className="flex justify-between">
            <div className="flex gap-2">
              <Avatar className="w-9 h-9 cursor-pointer" onClick={() => navigate(`/users/${review.id}`)}>
                <AvatarImage src={avatar} alt={review.username} />
                <AvatarFallback>{review.firstName[0] + review.lastName[0]}</AvatarFallback>
              </Avatar>
              <div className="flex flex-col gap-1">
                <CardTitle className="cursor-pointer hover:underline" onClick={() => navigate(`/users/${review.id}`)}>
                  {review.firstName + " " + review.lastName}
                </CardTitle>
                <CardDescription>{"@" + review.username}</CardDescription>
              </div>
            </div>
            <div className="flex items-center gap-1">
              <p className="font-bold text-xl">{review.rating}</p>
              <FontAwesomeIcon icon={faStar} />
            </div>
          </div>
          <div className="mt-3">
            <CardContent>
              <img
                className="rounded-sm cursor-pointer"
                src={podcast}
                alt={review.podcastName}
                onClick={() => navigate(`/podcasts/${review.podcastId}`)}
              />
              <div className="mt-3 flex flex-col">
                <span>
                  <span
                    className="font-bold cursor-pointer hover:underline"
                    onClick={() => navigate(`/podcasts/${review.podcastId}`)}
                  >
                    {review.podcastName}
                  </span>
                </span>
                <span className="italic text-sm">{review.type === "episode" && review.episodeName}</span>
                <div className="flex flex-col mt-4 gap-1">
                  <span className="text-xs text-gray-400 italic">{review.firstName + " wrote"}</span>
                  <span className="font-semibold">{review.comment}</span>
                  <span className="text-xs text-gray-400">{dateFormat(review.createdAt)}</span>
                </div>
              </div>
            </CardContent>
          </div>
        </CardHeader>
      </Card>
    </>
  );
}
