import { useParams, useNavigate } from "react-router-dom";
import { useState, useEffect, useContext } from "react";
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
  const navigate = useNavigate();
  const userID = useParams().userID;
  const [results, setResults] = useState<Friend[]>([]);

  useEffect(() => {
    // Friends data (Delete friends)
    async function getUserFriends() {
      const f_response: Response = await fetch(
        `${API_URL_BASE}/users/${userID}/friends`
      );
      const allFriendsData = await f_response.json();
      setResults(allFriendsData);
    }
    /*
  // Individual friend data
  async function getFriendInfo(allFriendsData: Friend[]) {
    const friendsData = await Promise.all(
      allFriendsData.map(async (friend: Friend) => {
        const fr_response: Response = await fetch(
          `${API_URL_BASE}/users/${friend.id}`
        );
        const friendData = await fr_response.json();
        return friendData;
      })
    );
    return friendsData;
  }
  */
    getUserFriends();
  });

  return (
    <div>
      {(results as Friend[]).map((user) => (
        <UserCard
          key={user.id}
          id={user.id}
          username={user.username}
          first_name={user.first_name}
          last_name={user.last_name}
          bio={user.bio}
          onClick={() => navigate(`/users/${user.id}`)}
        />
      ))}
    </div>
  );
}
