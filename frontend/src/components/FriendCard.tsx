import { Avatar, AvatarFallback, AvatarImage } from "@/components/ui/avatar";
import { Button } from "@/components/ui/button";
import {
  Item,
  ItemActions,
  ItemContent,
  ItemDescription,
  ItemMedia,
  ItemTitle,
} from "@/components/ui/item";
import minimalistAvatarM from "../assets/minimalistAvatarM.jpg";
import { LoginContext } from "../contexts/LoginContext";
import { Check, CircleX } from "lucide-react";
import { useContext } from "react";
import { useParams } from "react-router-dom";

type Friend = {
  id: string;
  dateAdded: string;
  username: string;
  firstName: string;
  lastName: string;
  bio: string;
};

type FriendCardProps = {
  mode?: "list" | "requests";
  username: string;
  bio: string;
  onClick: () => void;
  user: Friend;
  onFriendAccept: (userID: string, urlID: string, name: Friend) => void;
  onFriendReject: (userID: string, urlID: string, name: Friend) => void;
  onFriendDelete: (name: Friend) => void;
};

export default function FriendCard({
  mode,
  username,
  bio,
  onClick,
  user,
  onFriendAccept,
  onFriendReject,
  onFriendDelete,
}: FriendCardProps) {
  const { userID } = useContext(LoginContext);
  const urlID = useParams().userID;

  return (
    <div className="flex w-full max-w-lg flex-col gap-6 cursor-pointer">
      <Item variant="outline" onClick={onClick}>
        <ItemMedia>
          <Avatar className="size-10">
            <AvatarImage src={minimalistAvatarM} />
            <AvatarFallback>ER</AvatarFallback>
          </Avatar>
        </ItemMedia>
        <ItemContent>
          <ItemTitle>{username}</ItemTitle>
          <ItemDescription className="break-all">{bio}</ItemDescription>
        </ItemContent>
        <ItemActions>
          {/* Friends list actions */}
          {mode === "list" && userID == urlID && (
            <Button
              size="icon-sm"
              variant="outline"
              className="rounded-full"
              aria-label="Remove friend"
              onClick={(e) => {
                e.stopPropagation();
                onFriendDelete(user);
              }}
            >
              <CircleX />
            </Button>
          )}
          {/* Pending requests actions */}
          {mode === "requests" && (
            <div>
              <Button
                size="icon-sm"
                variant="outline"
                className="rounded-full"
                aria-label="Accept friend"
                onClick={(e) => {
                  e.stopPropagation();
                  onFriendAccept(user.id, userID, user);
                }}
              >
                <Check />
              </Button>
              <Button
                size="icon-sm"
                variant="outline"
                className="rounded-full"
                aria-label="Reject friend"
                onClick={(e) => {
                  e.stopPropagation();
                  onFriendReject(user.id, userID, user);
                }}
              >
                <CircleX />
              </Button>
            </div>
          )}
        </ItemActions>
      </Item>
    </div>
  );
}
