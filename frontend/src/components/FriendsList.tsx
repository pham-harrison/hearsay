import { Dialog, DialogTrigger, DialogContent } from "@/components/ui/dialog";
import { Button } from "@/components/ui/button";
import { ItemGroup } from "@/components/ui/item";

import { useParams, useNavigate } from "react-router-dom";
import { useState, useEffect, useContext } from "react";
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
  const [open, setOpen] = useState(false);

  useEffect(() => {
    function closeFriendsList() {
      if (open) setOpen(!open);
    }
    closeFriendsList();
  }, [urlID, userID]);

  return (
    <Dialog open={open} onOpenChange={setOpen}>
      <DialogTrigger asChild onClick={() => setOpen(true)}>
        <Button
          variant="outline"
          className="hover:bg-primary! hover:text-primary-foreground!"
        >
          {title}
        </Button>
      </DialogTrigger>
      <DialogContent className="max-h-[80vh] overflow-y-auto">
        <ItemGroup className="gap-3 mt-4">
          <>
            {friends.length !== 0 &&
              (friends as Friend[]).map((user) => {
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
            {friends.length === 0 && mode === "list" && (
              <span>Friend's list is empty</span>
            )}
            {friends.length === 0 && mode === "requests" && (
              <span>No pending requests</span>
            )}
          </>
        </ItemGroup>
      </DialogContent>
    </Dialog>
  );
}
