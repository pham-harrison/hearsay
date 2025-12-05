import { useParams, useNavigate } from "react-router-dom";
import { useState, useEffect, useContext } from "react";
import { LoginContext } from "../contexts/LoginContext";
import minimalistAvatarM from "../assets/minimalistAvatarM.jpg";
import { RainbowButton } from "@/components/ui/rainbow-button";
import * as React from "react";

import ReviewCard from "@/components/ReviewCard";
import UserBio from "@/components/UserBio";
import FriendsList from "@/components/FriendsList";
import {
  Dialog,
  DialogContent,
  DialogDescription,
  DialogHeader,
  DialogTitle,
} from "@/components/ui/dialog";
import {
  Card,
  CardContent,
  CardDescription,
  CardTitle,
} from "@/components/ui/card";
import {
  Accordion,
  AccordionContent,
  AccordionItem,
  AccordionTrigger,
} from "@/components/ui/accordion";
import { Button } from "@/components/ui/button";
import { Plus, Trash2, UserCheck, UserRoundPlus } from "lucide-react";
import { Tabs, TabsContent, TabsList, TabsTrigger } from "@/components/ui/tabs";
import { Input } from "@/components/ui/input";
import { toast } from "sonner";

type User = {
  id: string;
  username: string;
  firstName: string;
  lastName: string;
  bio: string;
};

type Friend = {
  id: string;
  dateAdded: string;
  username: string;
  firstName: string;
  lastName: string;
  bio: string;
};

type PodcastReview = {
  id: string;
  username: string;
  firstName: string;
  lastName: string;
  podcastId: string;
  podcastName: string;
  rating: string;
  comment: string;
  createdAt: string;
  onClick: () => void;
};

type EpisodeReview = PodcastReview & {
  episodeNum: string;
  episodeName: string;
};

type Playlist = {
  userId: string;
  name: string;
  description: string;
};

type Episode = {
  podcastId: string;
  podcastName: string;
  episodeNum: string;
  episodeName: string;
};

type Relationship = "friends" | "received" | "sent" | "none" | "self";

const API_URL_BASE = import.meta.env.VITE_API_URL;

export default function Profile() {
  // General constants / states
  const urlID = useParams().userID;
  const { loggedIn, userID, token } = useContext(LoginContext);
  const [refreshtoken, setRefreshToken] = useState<number>(0);
  const [refreshOnDelete, setRefreshOnDelete] = useState(0);
  const navigate = useNavigate();
  // User states
  const [profile, setProfile] = useState<User | null>(null);
  const [bio, setBio] = useState<string>("");
  // Review states
  const [podcastReviews, setPodcastReviews] = useState<PodcastReview[]>([]);
  const [episodeReviews, setEpisodeReviews] = useState<EpisodeReview[]>([]);
  // Playlist states
  const [playlists, setPlaylists] = useState<Playlist[]>([]);
  const [episodesByPlaylist, setEpisodesByPlaylist] = useState<
    Record<string, Episode[]>
  >({});
  const [playlistForm, setPlaylistForm] = useState<Playlist>({
    userId: "",
    name: "",
    description: "",
  });
  const [createPlaylistPopUp, setCreatePlaylistPopUp] =
    useState<boolean>(false);
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
      const response: Response = await fetch(`${API_URL_BASE}/users/${urlID}`);
      const data: User = await response.json();
      setProfile(data);
    }
    // Review data
    async function getUserPodcastReviews() {
      const response: Response = await fetch(
        `${API_URL_BASE}/users/${urlID}/reviews/podcasts`
      );
      const data = await response.json();
      setPodcastReviews(data);
    }
    async function getUserEpisodeReviews() {
      const response: Response = await fetch(
        `${API_URL_BASE}/users/${urlID}/reviews/episodes`
      );
      const data = await response.json();
      setEpisodeReviews(data);
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
        dateAdded: row.dateAdded,
        username: row.username,
        firstName: row.firstName,
        lastName: row.lastName,
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
    getUserPodcastReviews();
    getUserEpisodeReviews();
    getUserPlaylists();
  }, [urlID, loggedIn, userID, refreshtoken, refreshOnDelete]);

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
    if (playlistForm.name === "") {
      toast.error("Enter a name for your new playlist!");
      return;
    }

    try {
      const response = await fetch(
        `${API_URL_BASE}/users/${userID}/playlists/${playlistForm.name}`,
        {
          method: "POST",
          headers: {
            "Content-Type": "application/json",
            Authorization: `Bearer ${token}`,
          },
          body: JSON.stringify({ description: playlistForm.description }),
        }
      );
      const data = await response.json();
      if (!response.ok) {
        toast.error(data.detail);
        return;
      }
      toast.success("Playlist created!");
      const newPlaylist: Playlist = {
        userId: userID,
        name: playlistForm.name,
        description: playlistForm.description,
      };
      setPlaylists((prev) => [...prev, newPlaylist]);
      setPlaylistForm({ userId: "", name: "", description: "" });
      setCreatePlaylistPopUp(false);
    } catch (error) {
      console.error("Failed to add episode to playlist", error);
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
        toast.success("Playlist deleted");
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
        toast.success("Removed user from friends list");
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
        toast.success("Friend request sent!");
        const profileIdNum = Number(urlID);
        setSentRequests((prev) => {
          const next = new Set(prev);
          next.add(profileIdNum);
          return next;
        });
      }
    } catch (error) {
      toast.error("Failed to send friend request for user");
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
        toast.success("Friend request accepted!");
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
        toast.success("Friend request rejected :(");
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

  async function handlePlaylistClick(playlist: string) {
    getEpisodes(playlist);
  }

  // Episode data
  async function getEpisodes(playlist: string) {
    const response = await fetch(
      `${API_URL_BASE}/users/${urlID}/playlists/${playlist}/episodes`
    );
    const data = await response.json();
    setEpisodesByPlaylist((prev) => {
      const next = { ...prev, [playlist]: data };
      return next;
    });
  }

  async function handleEpisodeDelete(
    playlist: string,
    podcastId: string,
    episodeNum: string
  ) {
    console.log("called by: ", urlID, " on playlist: ", playlist);
    console.log(
      "deleting: podcastId: ",
      podcastId,
      " episodeNum: ",
      episodeNum
    );
    try {
      const response = await fetch(
        `${API_URL_BASE}/users/${urlID}/playlists/${playlist}/episodes`,
        {
          method: "DELETE",
          headers: {
            "Content-Type": "application/json",
            Authorization: `Bearer ${token}`,
          },
          body: JSON.stringify({ podcastId, episodeNum }),
        }
      );
      if (!response.ok) {
        console.error("Response from delete episode from playlist not ok");
      } else {
        getEpisodes(playlist);
        setRefreshOnDelete(() => {
          return refreshOnDelete + 1;
        });
        toast.success("Episode removed from playlist");
      }
    } catch (error) {
      console.error("Failed to delete episode from playlist", error);
    }
  }

  // Guard profile
  if (!profile) return null;

  return (
    <>
      <div className="flex flex-col justify-center ml-30 mr-30">
        <div className="p-2 bg-gradient-to-r from-purple-800 to-fuchsia-300 rounded-lg">
          <Card className="mb-2.5">
            <CardContent className="flex flex-col justify-center">
              <div className="flex flex-row items-end">
                <img
                  src={minimalistAvatarM}
                  className="w-48 h-48 rounded-full border-4 border-purple-500 mr-4"
                ></img>
                <div>
                  <CardTitle className="flex flex-row items-baseline text-8xl font-bold mb-4">
                    {profile.username}
                    <div className="text-lg ml-4">
                      <span className="mr-1.5">{profile.firstName}</span>
                      <span>{profile.lastName}</span>
                    </div>
                  </CardTitle>
                  <div className="text-lg">
                    <span>
                      {podcastReviews.length + episodeReviews.length} Reviews ·{" "}
                      {playlists.length} Playlists
                    </span>
                  </div>
                  <div></div>
                </div>
              </div>
            </CardContent>
            <div className="flex flex-row justify-start gap-4">
              {/* Bio and buttons cont */}
              <CardDescription className="ml-8 min-w-44 max-w-44 min-h-15 max-h-15 overflow-auto p-2">
                {profile.bio !== null ? profile.bio : <span>No bio . . .</span>}
              </CardDescription>
              <div className="flex flex-row items-top gap-4 p-0">
                {/* User buttons and lists */}
                {relationship === "none" && loggedIn && (
                  <div>
                    <RainbowButton
                      className="w-10 rounded-full transition-all hover:scale-105 active:scale-95 duration-150"
                      disabled={!loggedIn}
                      size="icon"
                      onClick={(e) => {
                        e.stopPropagation();
                        handleSendRequest(urlID);
                      }}
                    >
                      <UserRoundPlus />
                    </RainbowButton>
                  </div>
                )}
                {relationship === "sent" && (
                  <Button
                    className="w-10 rounded-full hover:bg-primary! hover:text-primary-foreground!"
                    variant="outline"
                    size="icon"
                    disabled
                  >
                    <UserRoundPlus />
                  </Button>
                )}
                {relationship === "friends" && (
                  <Button
                    className="w-10 rounded-full hover:bg-primary! hover:text-primary-foreground!"
                    variant="outline"
                    size="icon"
                    disabled
                  >
                    <UserCheck />
                  </Button>
                )}
                {userID === urlID && (
                  <UserBio
                    bio={bio}
                    onBioChange={setBio}
                    onConfirm={handleUpdateBio}
                  />
                )}
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
                <div className="relative">
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
                  {pendingList.length !== 0 && userID === urlID && (
                    <div className="absolute top-0 right-0">
                      <span className="relative flex size-3">
                        <span className="absolute inline-flex h-full w-full animate-ping rounded-full bg-yellow-500 opacity-75"></span>
                        <span className="relative inline-flex size-3 rounded-full bg-yellow-500"></span>
                      </span>
                    </div>
                  )}
                </div>
              </div>
            </div>
          </Card>

          <div className="bg-card rounded-lg">
            <Tabs defaultValue="podcastReviews" className="w-max-full p-2">
              <TabsList>
                <TabsTrigger
                  value="podcastReviews"
                  className="hover:bg-primary! hover:text-primary-foreground!"
                >
                  Podcast Reviews
                </TabsTrigger>
                <TabsTrigger
                  value="episodeReviews"
                  className="hover:bg-primary! hover:text-primary-foreground!"
                >
                  Episode Reviews
                </TabsTrigger>
                <TabsTrigger
                  value="playlists"
                  className="hover:bg-primary! hover:text-primary-foreground!"
                >
                  Playlists
                </TabsTrigger>
              </TabsList>
              <TabsContent value="podcastReviews">
                <div className="flex flex-wrap justify-center gap-10 w-max-full">
                  {(podcastReviews as PodcastReview[]).map((review, i) => (
                    <ReviewCard
                      key={i}
                      review={{
                        id: review.id,
                        type: "podcast",
                        username: review.username,
                        firstName: review.firstName,
                        lastName: review.lastName,
                        podcastId: review.podcastId,
                        podcastName: review.podcastName,
                        rating: review.rating,
                        comment: review.comment,
                        createdAt: review.createdAt,
                        onClick: () => navigate(`/users/${review.id}`),
                      }}
                    />
                  ))}
                </div>
              </TabsContent>
              <TabsContent value="episodeReviews">
                <div className="flex flex-wrap justify-center gap-10 w-max-full">
                  {(episodeReviews as EpisodeReview[]).map((review, i) => (
                    <ReviewCard
                      key={i}
                      review={{
                        type: "episode",
                        id: review.id,
                        firstName: review.firstName,
                        lastName: review.lastName,
                        username: review.username,
                        podcastId: review.podcastId,
                        podcastName: review.podcastName,
                        episodeName: review.episodeName,
                        episodeNum: review.episodeNum,
                        rating: review.rating,
                        comment: review.comment,
                        createdAt: review.createdAt,
                        onClick: () => {},
                      }}
                    />
                  ))}
                </div>
              </TabsContent>
              <TabsContent value="playlists">
                <Accordion type="single" collapsible>
                  {playlists.map((playlist) => {
                    const episodes = episodesByPlaylist[playlist.name] ?? [];
                    return (
                      <AccordionItem
                        key={playlist.name}
                        className="m-2 p-2 rounded-lg bg-card"
                        value={playlist.name}
                        onClick={() => {
                          handlePlaylistClick(playlist.name);
                        }}
                      >
                        <AccordionTrigger className="hover:no-underline items-center">
                          <div className="flex flex-row justify-between">
                            <div className="flex flex-col">
                              <div className="text-lg font-bold hover:underline">
                                {playlist.name}
                              </div>
                              <div className="">{playlist.description}</div>
                            </div>
                            <div className=""></div>
                          </div>
                          {userID === urlID && (
                            <Button
                              className="w-10 ml-auto hover:bg-primary! hover:text-primary-foreground!"
                              variant="outline"
                              size="icon"
                              onClick={(e) => {
                                e.stopPropagation();
                                handlePlaylistDelete(playlist.name);
                              }}
                            >
                              <Trash2 />
                            </Button>
                          )}
                        </AccordionTrigger>
                        <AccordionContent className="">
                          <div>
                            {episodes.length === 0 && (
                              <div className="bg-card rounded-sm p-2 mt-2 mb-2">
                                <h1 className="italic">Playlist is empty</h1>
                              </div>
                            )}
                            {episodes.length !== 0 &&
                              (episodes as Episode[]).map((episode) => (
                                <div
                                  className="flex flex-row mt-2 mb-2 p-2 items-center bg-gradient-to-r from-purple-800 to-fuchsia-300 
                                   transition-all duration-300 ease-in-out 
                                   hover:from-purple-900 hover:to-fuchsia-400 rounded-sm"
                                  key={
                                    episode.episodeName +
                                    episode.podcastName +
                                    episode.podcastId +
                                    episode.episodeNum
                                  }
                                  onClick={() =>
                                    navigate(
                                      `/podcasts/${episode.podcastId}/episodes/${episode.episodeNum}`
                                    )
                                  }
                                >
                                  <div className="flex flex-col">
                                    <div className="font-bold text-lg">
                                      {episode.episodeName}
                                    </div>
                                    <div className="flex flex-row">
                                      {episode.podcastName}
                                      <h1 className="ml-1 mr-1">
                                        {" "}
                                        · Episode:{" "}
                                      </h1>
                                      {episode.episodeNum}
                                    </div>
                                  </div>
                                  {userID === urlID && (
                                    <Button
                                      className="w-10 ml-auto hover:bg-primary! hover:text-primary-foreground!"
                                      variant="outline"
                                      size="icon"
                                      onClick={(e) => {
                                        e.stopPropagation();
                                        handleEpisodeDelete(
                                          playlist.name,
                                          episode.podcastId,
                                          episode.episodeNum
                                        );
                                      }}
                                    >
                                      <Trash2 />
                                    </Button>
                                  )}
                                </div>
                              ))}
                          </div>
                        </AccordionContent>
                      </AccordionItem>
                    );
                  })}
                  {userID === urlID && (
                    <AccordionItem
                      className="m-2 p-2 rounded-lg bg-card flex flex-row items-center gap-4"
                      value={"createPlaylist"}
                      onClick={() => setCreatePlaylistPopUp(true)}
                    >
                      <Button
                        className="w-15 h-15 rounded-full hover:bg-primary! hover:text-primary-foreground!"
                        variant="outline"
                        size="icon"
                        onClick={() => setCreatePlaylistPopUp(true)}
                      >
                        <Plus />
                      </Button>
                      <div className="flex flex-row justify-start">
                        <div className="flex flex-col">
                          <div className="text-lg hover:underline">
                            Create playlist
                          </div>
                        </div>
                      </div>
                    </AccordionItem>
                  )}
                </Accordion>

                {
                  <Dialog
                    open={createPlaylistPopUp}
                    onOpenChange={setCreatePlaylistPopUp}
                  >
                    <DialogContent>
                      <DialogHeader>
                        <DialogTitle>New Playlist</DialogTitle>
                        <DialogDescription>
                          Create your new playlist
                        </DialogDescription>
                      </DialogHeader>
                      <form onSubmit={handlePlaylistCreate}>
                        <DialogDescription className="font-medium mb-3">
                          Playlist Name
                        </DialogDescription>
                        <Input
                          type="text"
                          maxLength={20}
                          onChange={(e) =>
                            setPlaylistForm({
                              ...playlistForm,
                              name: e.target.value,
                            })
                          }
                        ></Input>
                        <DialogDescription className="font-medium my-3">
                          Add an optional description
                        </DialogDescription>
                        <Input
                          type="text"
                          maxLength={50}
                          onChange={(e) =>
                            setPlaylistForm({
                              ...playlistForm,
                              description: e.target.value,
                            })
                          }
                        ></Input>
                        <div className="flex justify-end mt-3">
                          <Button type="submit">Create Playlist</Button>
                        </div>
                      </form>
                    </DialogContent>
                  </Dialog>
                }
              </TabsContent>
            </Tabs>
          </div>
        </div>
      </div>
    </>
  );
}
