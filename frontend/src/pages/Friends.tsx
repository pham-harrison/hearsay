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

  // async function handleSendRequest(friend: Friend) {
  //   try {
  //     const response = await fetch(
  //       `${API_URL_BASE}/users/${userID}/request/${friend.id}`,
  //       {
  //         method: "POST",
  //         headers: {
  //           "Content-Type": "application/json",
  //           Authorization: `Bearer ${token}`,
  //         },
  //       }
  //     );
  //     if (!response.ok) {
  //       console.error("Response from send friend request not ok");
  //     } else {
  //       setFriends((prev) => prev.filter((fr) => fr.id !== friend.id));
  //     }
  //   } catch (error) {
  //     console.error("Failed to delete friend for user", error);
  //   }
  // }

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
