import { useParams } from "react-router-dom";
import { useState, useEffect, useContext } from "react";
import { LoginContext } from "../contexts/LoginContext";
import minimalistAvatarM from "../assets/minimalistAvatarM.jpg";
import * as React from "react";

import Playlists from "./Playlists";
import Reviews from "./Reviews";
import UserBio from "@/components/UserBio";
import FriendsList from "@/components/FriendsList";

type DisplayType = "reviews" | "playlists";

type User = {
  id: string;
  username: string;
  first_name: string;
  last_name: string;
  bio: string;
};

type Friend = {
  id: string;
  date_added: string;
  username: string;
  first_name: string;
  last_name: string;
  bio: string;
};

type Playlist = {
  name: string;
  description: string;
};

type Relationship = "friends" | "received" | "sent" | "none" | "self";

type activeModal = "create" | null;

const API_URL_BASE = import.meta.env.VITE_API_URL;

export default function Profile() {
  // General constants / states
  const urlID = useParams().userID;
  const { loggedIn, userID, token } = useContext(LoginContext);
  const [refreshtoken, setRefreshToken] = useState<number>(0);
  const [displayType, setDisplayType] = useState<DisplayType>("reviews");
  // User states
  const [profile, setProfile] = useState<User | null>(null);
  const [bio, setBio] = useState<string>("");
  // Playlist states
  const [activeModal, setActiveModal] = useState<activeModal>(null);
  const [playlistName, setPlaylistName] = useState<string>("");
  const [playlistDesc, setPlaylistDesc] = useState<string>("");
  const [playlists, setPlaylists] = useState<Playlist[]>([]);
  // Friends states
  const [friends, setFriends] = useState<Friend[]>([]);
  const [pendingList, setPendingList] = useState<Friend[]>([]);
  const [pendingRequests, setPendingRequests] = useState<Set<number>>(
    new Set()
  );
  const [sentRequests, setSentRequests] = useState<Set<number>>(new Set());
  // Relationship
  let relationship: Relationship = "none";
  if (userID && urlID) {
    relationship = getRelationship(
      userID,
      urlID,
      sentRequests,
      pendingRequests,
      friends
    );
  }

  useEffect(() => {
    async function getUserInfo() {
      // Profile data
      const u_response: Response = await fetch(
        `${API_URL_BASE}/users/${urlID}`
      );
      const profileData: User = await u_response.json();
      setProfile(profileData);
    }
    // Playlist data
    async function getUserPlaylists() {
      const response: Response = await fetch(
        `${API_URL_BASE}/users/${urlID}/playlists`
      );
      const data = await response.json();
      setPlaylists(data);
    }
    // Friends data
    async function getUserFriends() {
      const response: Response = await fetch(
        `${API_URL_BASE}/users/${urlID}/friends`
      );
      const data = await response.json();
      const mapped: Friend[] = data.map((row: any) => ({
        id: String(row.id),
        date_added: row.date_added,
        username: row.username,
        first_name: row.first_name,
        last_name: row.last_name,
        bio: row.bio,
      }));
      setFriends(mapped);
    }
    // Pending friends data
    async function getUserPendingRequests() {
      if (!userID) return;
      const response: Response = await fetch(
        `${API_URL_BASE}/users/${userID}/pending`
      );
      const data = await response.json();
      const ids = new Set<number>(data.map((row: any) => Number(row.id)));
      setPendingList(data);
      setPendingRequests(ids);
    }
    // Sent friend requests data
    async function getUserSentRequests() {
      if (!userID) return;
      const response: Response = await fetch(
        `${API_URL_BASE}/users/${userID}/sent`
      );
      const data = await response.json();
      const ids = new Set<number>(data.map((row: any) => Number(row.id)));
      setSentRequests(ids);
    }

    getUserInfo();
    getUserFriends();
    getUserPendingRequests();
    getUserSentRequests();
    getUserPlaylists();
  }, [urlID, loggedIn, userID, refreshtoken]);

  // Get relationship status
  function getRelationship(
    userID: string,
    urlID: string,
    sentRequests: Set<number>,
    pendingRequests: Set<number>,
    friends: Friend[]
  ): Relationship {
    const userIdNum = Number(userID);
    const urlIdNum = Number(urlID);
    if (userIdNum === urlIdNum) return "self";
    if (friends.some((f) => f.id === userID)) return "friends";
    if (sentRequests.has(urlIdNum)) return "sent";
    if (pendingRequests.has(urlIdNum)) return "received";
    return "none";
  }

  // Update bio
  async function handleUpdateBio(e: React.FormEvent) {
    e.preventDefault();
    console.log("confirm clicked!");
    try {
      const response = await fetch(`${API_URL_BASE}/users/${userID}`, {
        method: "PUT",
        headers: {
          "Content-Type": "application/json",
          Authorization: `Bearer ${token}`,
        },
        body: JSON.stringify({ bio: bio }),
      });
      if (!response.ok) {
        console.error("Response not ok from update bio");
      } else {
        if (profile) {
          setProfile((prev) => ({
            ...prev!,
            bio: bio,
          }));
        }
      }
    } catch (error) {
      console.error("Failed to update bio", error);
    }
  }

  // Create playlist
  async function handlePlaylistCreate(e: React.FormEvent) {
    e.preventDefault();
    if (!playlistName) {
      alert("Please enter a playlist name");
      return;
    }
    try {
      const response = await fetch(
        `${API_URL_BASE}/users/${userID}/playlists/${playlistName}`,
        {
          method: "POST",
          headers: {
            "Content-Type": "application/json",
            Authorization: `Bearer ${token}`,
          },
          body: JSON.stringify({ description: playlistDesc }),
        }
      );
      if (!response.ok) {
        console.error("Response not ok from create playlist");
      } else {
        const newPlaylist: Playlist = {
          name: playlistName,
          description: playlistDesc,
        };
        setPlaylists((prev) => [...prev, newPlaylist]);
      }
    } catch (error) {
      console.error("Failed to create playlist", error);
    }
  }

  // Delete playlist
  async function handlePlaylistDelete(playlist: string) {
    try {
      const response = await fetch(
        `${API_URL_BASE}/users/${urlID}/playlists/${playlist}`,
        {
          method: "DELETE",
          headers: {
            "Content-Type": "application/json",
            Authorization: `Bearer ${token}`,
          },
        }
      );
      if (!response.ok) {
        console.error("Response from delete playlist not ok");
      } else {
        setPlaylists((prev) => prev.filter((pl) => pl.name !== playlist));
      }
    } catch (error) {
      console.error("Failed to delete playlist", error);
    }
  }

  // Delete friend from friends list
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

  // Send friend request
  async function handleSendRequest(urlID: string | undefined) {
    if (!urlID) return;
    try {
      const response = await fetch(
        `${API_URL_BASE}/users/${userID}/request/${urlID}`,
        {
          method: "POST",
          headers: {
            "Content-Type": "application/json",
            Authorization: `Bearer ${token}`,
          },
        }
      );
      if (!response.ok) {
        console.error("Response from send friend request not ok");
      } else {
        const profileIdNum = Number(urlID);
        setSentRequests((prev) => {
          const next = new Set(prev);
          next.add(profileIdNum);
          return next;
        });
      }
    } catch (error) {
      console.error("Failed to send friend request for user", error);
    }
  }

  // Accept friend request
  async function handleAcceptRequest(
    requester: string,
    responder: string,
    friend: Friend | null
  ) {
    try {
      const response = await fetch(
        `${API_URL_BASE}/users/${responder}/request/${requester}`,
        {
          method: "PUT",
          headers: {
            "Content-Type": "application/json",
            Authorization: `Bearer ${token}`,
          },
        }
      );
      if (!response.ok) {
        console.error("Response from accept friend request not ok");
      } else {
        setSentRequests((prev) => {
          const next = new Set(prev);
          next.delete(Number(responder));
          return next;
        });
        // Accepting from pending list
        if (friend) {
          setFriends((prev) => {
            const next = [...prev, friend];
            return next;
          });
          setPendingList((prev) => prev.filter((fr) => fr.id !== friend.id));
        }
        // Accepting from requester's page
        else {
          setRefreshToken(refreshtoken + 1);
        }
      }
    } catch (error) {
      console.error("Failed to accept friend for user", error);
    }
  }

  // Reject friend request
  async function handleRejectRequest(
    requester: string | null,
    responder: string,
    friend: Friend | null
  ) {
    if (!requester) return;
    try {
      const response = await fetch(
        `${API_URL_BASE}/users/${responder}/request/${requester}`,
        {
          method: "DELETE",
          headers: {
            "Content-Type": "applications/json",
            Authorization: `Bearer ${token}`,
          },
        }
      );
      if (!response.ok) {
        console.error("Response from reject friend request not ok");
      } else {
        // Rejecting on requester's user page
        if (!friend) {
          setPendingRequests((prev) => {
            const next = new Set(prev);
            next.delete(Number(requester));
            return next;
          });
        } else {
          // Rejecting from pending list
          setPendingList((prev) => prev.filter((fr) => fr.id !== friend.id));
        }
        setRefreshToken(refreshtoken + 1);
      }
    } catch (error) {
      console.error("Failed to reject friend for user", error);
    }
  }

  // Guard profile
  if (!profile) return null;

  // test data
  const fake: User = {
    id: "1",
    username: "fake-chan",
    first_name: "Fake",
    last_name: "Chan",
    bio: "Hi I'm fake chan REEEEEEEEEEE",
  };

  return (
    <>
      <div>
        <img
          src={minimalistAvatarM}
          className="w-48 h-48 rounded-full border-4 border-purple-500"
        ></img>
        <h1>{profile.username}</h1>
        <p>{profile.bio}</p>
        {userID === urlID && (
          <UserBio bio={bio} onBioChange={setBio} onConfirm={handleUpdateBio} />
        )}
      </div>
      <div>
        {relationship === "none" && loggedIn && (
          <button
            className="bg-green-500 hover:bg-green-700 text-white font-bold py-.5 px-1 rounded"
            onClick={(e) => {
              e.stopPropagation();
              handleSendRequest(urlID);
            }}
          >
            Add Friend
          </button>
        )}
        {relationship === "received" && (
          <>
            <button
              className="bg-green-500 hover:bg-green-700 text-white font-bold py-.5 px-1 rounded"
              onClick={(e) => {
                e.stopPropagation();
                if (urlID) {
                  handleAcceptRequest(urlID, userID, null);
                }
              }}
            >
              Accept Request
            </button>
            <button
              className="bg-red-500 hover:bg-red-700 text-white font-bold py-.5 px-1 rounded"
              onClick={(e) => {
                e.stopPropagation();
                if (urlID) {
                  handleRejectRequest(urlID, userID, null);
                }
              }}
            >
              Reject Request
            </button>
          </>
        )}
        {relationship === "friends" && (
          <button
            disabled
            className="bg-blue-900 text-white font-bold py-.5 px-1 rounded"
          >
            Friends
          </button>
        )}
        {relationship === "sent" && (
          <button
            disabled
            className="bg-blue-900 text-white font-bold py-.5 px-1 rounded"
          >
            Request Sent
          </button>
        )}
      </div>
      {/* Friends list */}
      <FriendsList
        title="Friends list"
        friends={friends}
        mode="list"
        onFriendAccept={handleAcceptRequest}
        onFriendReject={handleRejectRequest}
        onFriendDelete={handleDeleteFriend}
      />
      {/* Pending requests */}
      {userID === urlID && (
        <FriendsList
          title="Pending requests"
          friends={pendingList}
          mode="requests"
          onFriendAccept={handleAcceptRequest}
          onFriendReject={handleRejectRequest}
          onFriendDelete={handleDeleteFriend}
        />
      )}
      <select
        value={displayType}
        onChange={(e) => setDisplayType(e.target.value as DisplayType)}
      >
        <option value={"reviews"}>Reviews</option>
        <option value={"playlists"}>Playlists</option>
      </select>
      {loggedIn && userID === urlID && displayType === "playlists" && (
        <button
          className="bg-green-500 hover:bg-green-700 text-white font-bold py-2 px-4 rounded"
          onClick={
            activeModal !== "create"
              ? () => setActiveModal("create")
              : () => setActiveModal(null)
          }
        >
          Create
        </button>
      )}
      {displayType === "reviews" && <Reviews />}
      {displayType === "playlists" && (
        <Playlists
          playlists={playlists}
          onPlaylistDelete={handlePlaylistDelete}
        />
      )}
      {activeModal === "create" && (
        <div className="bg-purple-900 fixed top-1/2 left-1/2 transform -translate-x-1/2 -translate-y-1/2">
          <form className="flex flex-col" onSubmit={handlePlaylistCreate}>
            <label>Name of new playlist</label>
            <input
              type="text"
              onChange={(e) => setPlaylistName(e.target.value)}
              placeholder="Title..."
            ></input>
            <input
              type="text"
              onChange={(e) => setPlaylistDesc(e.target.value)}
              placeholder="Description..."
            ></input>
            <button
              type="submit"
              className="bg-green-500 hover:bg-green-700 text-white font-bold py-2 px-4 rounded"
            >
              Confirm
            </button>
          </form>
        </div>
      )}
    </>
  );
}
