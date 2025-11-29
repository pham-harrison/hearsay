import { Dialog, DialogTrigger, DialogContent } from "@/components/ui/dialog";
import { Button } from "@/components/ui/button";
import { ItemGroup } from "@/components/ui/item";

import { useParams, useNavigate } from "react-router-dom";
import { useEffect, useContext } from "react";
import { LoginContext } from "../contexts/LoginContext";
import FriendCard from "./FriendCard";

type Friend = {
  id: string;
  dateAdded: string;
  username: string;
  firstName: string;
  lastName: string;
  bio: string;
};

type FriendProps = {
  title: string;
  friends: Friend[];
  mode: "list" | "requests";
  onFriendAccept: (userID: string, urlID: string, name: Friend) => void;
  onFriendReject: (userID: string, urlID: string, name: Friend) => void;
  onFriendDelete: (name: Friend) => void;
};

export default function FriendsList({
  title,
  friends,
  mode,
  onFriendAccept,
  onFriendReject,
  onFriendDelete,
}: FriendProps) {
  const { userID } = useContext(LoginContext);
  const navigate = useNavigate();
  const urlID = useParams().userID;

  useEffect(() => {}, [urlID, userID]);

  return (
    <Dialog>
      <DialogTrigger asChild>
        <Button variant="outline">{title}</Button>
      </DialogTrigger>
      <DialogContent className="max-h-[80vh] overflow-y-auto">
        <ItemGroup className="gap-3">
          <>
            {(friends as Friend[]).map((user) => {
              return (
                <>
                  <div key={user.id} className="flex items-center">
                    <FriendCard
                      key={user.id}
                      mode={mode}
                      username={user.username}
                      bio={user.bio}
                      user={user}
                      onClick={() => navigate(`/users/${user.id}`)}
                      onFriendAccept={onFriendAccept}
                      onFriendReject={onFriendReject}
                      onFriendDelete={onFriendDelete}
                    />
                  </div>
                </>
              );
            })}
          </>
        </ItemGroup>
      </DialogContent>
    </Dialog>
  );
}
