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
import avatar from "../assets/minimalistAvatarM.jpg";
import { faStar } from "@fortawesome/free-solid-svg-icons";
import { FontAwesomeIcon } from "@fortawesome/react-fontawesome";
import { useNavigate } from "react-router-dom";
import dateFormat from "@/utils/dateFormat";

type PageReviewCardProps = {
  id: string;
  rating: string;
  comment: string;
  createdAt: string;
  username: string;
  firstName: string;
  lastName: string;
  width: string;
};

export default function PageReviewCard({
  id,
  rating,
  comment,
  createdAt,
  username,
  firstName,
  lastName,
  width,
}: PageReviewCardProps) {
  const navigate = useNavigate();
  return (
    <Card className={`${width} h-40 shrink-0 cursor-pointer hover:scale-102 duration-150`}>
      <CardHeader>
        <div className="flex justify-between">
          <div className="flex gap-2">
            <Avatar className="w-9 h-9 cursor-pointer" onClick={() => navigate(`/users/${id}`)}>
              <AvatarImage src={avatar} alt={username} />
              <AvatarFallback>{firstName[0] + lastName[0]}</AvatarFallback>
            </Avatar>
            <div className="flex flex-col gap-1">
              <CardTitle className="cursor-pointer hover:underline" onClick={() => navigate(`/users/${id}`)}>
                {firstName + " " + lastName}
              </CardTitle>
              <CardDescription>{"@" + username}</CardDescription>
            </div>
          </div>
          <div className="flex items-center gap-1">
            <p className="font-bold text-xl">{rating}</p>
            <FontAwesomeIcon icon={faStar} />
          </div>
        </div>
      </CardHeader>
      <CardContent>
        <div className="flex flex-col gap-1 items-baseline">
          <span className="font-normal text-sm">{comment}</span>
          <span className="text-xs text-gray-400">{dateFormat(createdAt)}</span>
        </div>
      </CardContent>
    </Card>
  );
}
