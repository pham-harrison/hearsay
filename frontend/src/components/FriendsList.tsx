import { Dialog, DialogTrigger, DialogContent } from "@/components/ui/dialog";
import { Button } from "@/components/ui/button";
import { ItemGroup } from "@/components/ui/item";

import { useParams, useNavigate } from "react-router-dom";
import { useEffect, useContext } from "react";
import { LoginContext } from "../contexts/LoginContext";
import UserCard from "./UserCard";

type Friend = {
  id: string;
  date_added: string;
  username: string;
  first_name: string;
  last_name: string;
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
                    <UserCard
                      key={user.id}
                      mode={mode}
                      id={user.id}
                      username={user.username}
                      first_name={user.first_name}
                      last_name={user.last_name}
                      bio={user.bio}
                      onClick={() => navigate(`/users/${user.id}`)}
                      onFriendAccept={onFriendAccept}
                      onFriendReject={onFriendReject}
                      onFriendDelete={onFriendDelete}
                      user={user}
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
