import { useState } from "react";

export default function Home() {
  const [podcasts, setPodcasts] = useState<any[]>([])
  const [showPodcasts, setShowPodcasts] = useState(false);
  const [username, setUsername] = useState("");
  
  async function handleClick() {
    try {
      const response = await fetch("http://localhost:8000/podcasts/");
      const data = await response.json();
      console.log(data);
      setShowPodcasts(!showPodcasts)
      setPodcasts(data)
    } catch (error) {
      console.error(error)
    }
  }

  async function handleUserSearch() {
    try {
      const response = await fetch(`http://localhost:8000/users/username/${username}`);
      const data = await response.json();
      console.log(data);
    } catch (error) {
      console.error(error)
    }
  }


  return (
    <>
      <button onClick={handleClick}>Get Podcasts</button>
      {showPodcasts && (
        <ul>
          {podcasts.map((podcast) => (
            <li key={podcast.podcast_id}>{podcast.name}</li>
          ))}
        </ul>
      )}
      <input type="text" placeholder="Enter username" value={username} onChange={(e) => setUsername(e.target.value)} />
      <button onClick={handleUserSearch}></button>
    </>
  )
}