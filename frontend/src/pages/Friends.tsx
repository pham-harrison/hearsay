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
const API_URL_BASE = import.meta.env.VITE_API_URL;

export default function Friends() {
  const { loggedIn, userID, token } = useContext(LoginContext);
  const navigate = useNavigate();
  const urlID = useParams().userID;
  const [friends, setFriends] = useState<Friend[]>([]);

  useEffect(() => {
    // Friends data (Delete friends)
    async function getUserFriends() {
      const f_response: Response = await fetch(
        `${API_URL_BASE}/users/${urlID}/friends`
      );
      const allFriendsData = await f_response.json();
      setFriends(allFriendsData);
    }
    getUserFriends();
  }, [urlID, userID]);

  async function handleDeleteFriend(friend: Friend) {
    try {
      const response = await fetch(
        `${API_URL_BASE}/users/${userID}/friends/${friend.id}`,
        {
          method: "DELETE",
          headers: {
            "Content-Type": "application/json",
            Authorization: `Bearer ${token}`,
          },
        }
      );
      if (!response.ok) {
        console.error("Response from delete friend not ok");
      } else {
        setFriends((prev) => prev.filter((fr) => fr.id !== friend.id));
      }
    } catch (error) {
      console.error("Failed to delete friend for user", error);
    }
  }

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
                  onClick={() => handleDeleteFriend(user)}
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
