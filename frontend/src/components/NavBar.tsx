import React, { useState, useEffect } from "react";
import { useNavigate } from "react-router-dom";
import microphoneIcon from "../assets/microphone.png";
import SearchBar from "./SearchBar";

const API_URL_BASE = import.meta.env.VITE_API_URL;

export default function NavBar() {
  const navigate = useNavigate();
  const [showLogin, setShowLogin] = useState(false);
  const [username, setUsername] = useState("");
  const [password, setPassword] = useState("");

  async function handleLogin(e: React.FormEvent) {
    e.preventDefault();
    try {
      const response = await fetch(`${API_URL_BASE}/users/login`, {
        method: "POST",
        headers: {
          "Content-Type": "application/json",
        },
        body: JSON.stringify({ username: username, password: password }),
      });
      const data = await response.json();
      console.log(data);
    } catch (error) {
      console.log("Failed to log in", error);
    }
  }

  return (
    <div className="flex bg-yellow-100 h-16 sticky top-0 left-0 justify-between items-center pr-3">
      <img src={microphoneIcon} className="w-15 h-14.5 cursor-pointer" onClick={() => navigate("/")} />
      <SearchBar />
      <div className="relative">
        <button onClick={() => setShowLogin(!showLogin)}>log in</button>
        <button>register</button>
        {showLogin && (
          <div className="bg-red-200 fixed top-1/2 left-1/2 transform -translate-x-1/2 -translate-y-1/2">
            <form className="flex flex-col" onSubmit={handleLogin}>
              <label>Username</label>
              <input type="text" onChange={(e) => setUsername(e.target.value)} placeholder="Username"></input>
              <label>Password</label>
              <input type="password" onChange={(e) => setPassword(e.target.value)} placeholder="Password"></input>
              <button type="submit">Log In</button>
            </form>
          </div>
        )}
      </div>
    </div>
  );
}
