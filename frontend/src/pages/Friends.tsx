import { useParams, useNavigate } from "react-router-dom";
import { useState, useEffect, useContext } from "react";
import { LoginContext } from "../contexts/LoginContext";
import UserCard from "../components/UserCard";

type Friend = {
  id: string;
  date_added: string;
  username: string;
  first_name: string;
  last_name: string;
  bio: string;
};

type FriendProps = {
  friends: Friend[];
  onFriendDelete: (name: Friend) => void;
};

export default function Friends({ friends, onFriendDelete }: FriendProps) {
  const { loggedIn, userID } = useContext(LoginContext);
  const navigate = useNavigate();
  const urlID = useParams().userID;

  useEffect(() => {}, [urlID, userID]);

  return (
    <>
      {(friends as Friend[]).map((user) => {
        return (
          <>
            <div key={user.id} className="flex items-center">
              <UserCard
                key={user.id}
                id={user.id}
                username={user.username}
                first_name={user.first_name}
                last_name={user.last_name}
                bio={user.bio}
                onClick={() => navigate(`/users/${user.id}`)}
              />
              {urlID === userID && (
                <button
                  className="bg-red-500 hover:bg-red-700 text-white py-0.5 px-1 rounded"
                  onClick={() => onFriendDelete(user)}
                >
                  Remove Friend
                </button>
              )}
            </div>
          </>
        );
      })}
    </>
  );
}
