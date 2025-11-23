import React, { useState, useEffect, useContext } from "react";
import { useNavigate } from "react-router-dom";
import microphoneIcon from "../assets/microphone.png";
import SearchBar from "./SearchBar";
import { LoginContext } from "../contexts/LoginContext";
import { jwtDecode } from "jwt-decode";

const API_URL_BASE = import.meta.env.VITE_API_URL;

type activeModal = "login" | "register" | null;

type LoginInfo = {
  username: string;
  password: string;
};

type RegisterInfo = {
  email: string;
  username: string;
  password: string;
  firstName: string;
  lastName: string;
};

export default function NavBar() {
  const navigate = useNavigate();
  const [activeModal, setActiveModal] = useState<activeModal>(null);
  const { loggedIn, setLoggedIn, setUserID } = useContext(LoginContext);
  const [loginInfo, setLoginInfo] = useState<LoginInfo>({
    username: "",
    password: "",
  });
  const [registerInfo, setRegisterInfo] = useState<RegisterInfo>({
    email: "",
    username: "",
    password: "",
    firstName: "",
    lastName: "",
  });

  async function handleLogin(e: React.FormEvent) {
    e.preventDefault();
    if (!areAllFieldsFilled(loginInfo)) {
      alert("All fields must be filled");
      return;
    }
    try {
      const response = await fetch(`${API_URL_BASE}/users/login`, {
        method: "POST",
        headers: { "Content-Type": "application/json" },
        body: JSON.stringify(loginInfo),
      });
      const data = await response.json();
      if (!response.ok) {
        alert(data.detail);
        return;
      }
      // console.log(data.access_token);
      localStorage.setItem("jwt", data.access_token);
      const decodedToken = jwtDecode(data.access_token);
      if (decodedToken.sub) setUserID(decodedToken.sub);
      setLoggedIn(true);
      setActiveModal(null);
    } catch (error) {
      console.log("Failed to log in", error);
    }
  }

  function areAllFieldsFilled(object: Record<string, string>) {
    return Object.values(object).every((value) => value);
  }

  async function handleRegister(e: React.FormEvent) {
    e.preventDefault();
    if (!areAllFieldsFilled(registerInfo)) {
      alert("All fields must be filled");
      return;
    }
    if (!registerInfo.email.endsWith(".com")) {
      alert("Email must end with .com");
      return;
    }
    try {
      const response = await fetch(`${API_URL_BASE}/users/register`, {
        method: "POST",
        headers: { "Content-Type": "application/json" },
        body: JSON.stringify(registerInfo),
      });
      const data = await response.json();
      if (!response.ok) {
        alert(data.detail);
        return;
      }
      handleLogin(e);
    } catch (error) {
      console.log("Failed to register", error);
    }
  }

  function handleReset() {
    setRegisterInfo({
      email: "",
      username: "",
      password: "",
      firstName: "",
      lastName: "",
    });
  }

  return (
    <div className="flex bg-yellow-100 h-16 sticky top-0 left-0 justify-between items-center pr-3">
      <img src={microphoneIcon} className="w-15 h-14.5 cursor-pointer" onClick={() => navigate("/")} />
      <SearchBar />
      <div className="relative">
        {loggedIn ? (
          <div>
            <button
              onClick={() => {
                setLoggedIn(false);
              }}
            >
              User
            </button>
          </div>
        ) : (
          <div className="flex gap-1">
            <button className="cursor-pointer" onClick={() => setActiveModal(activeModal !== "login" ? "login" : null)}>
              log in
            </button>
            <button
              className="cursor-pointer"
              onClick={() => setActiveModal(activeModal !== "register" ? "register" : null)}
            >
              register
            </button>
            {activeModal === "login" && (
              <div className="bg-red-200 fixed top-1/2 left-1/2 transform -translate-x-1/2 -translate-y-1/2">
                <form className="flex flex-col" onSubmit={handleLogin}>
                  <label>Username</label>
                  <input
                    type="text"
                    onChange={(e) => setLoginInfo({ ...loginInfo, username: e.target.value })}
                    placeholder="Username"
                  ></input>
                  <label>Password</label>
                  <input
                    type="password"
                    onChange={(e) => setLoginInfo({ ...loginInfo, password: e.target.value })}
                    placeholder="Password"
                  ></input>
                  <button type="submit">Log In</button>
                </form>
              </div>
            )}
            {activeModal === "register" && (
              <div className="bg-red-200 fixed top-1/2 left-1/2 transform -translate-x-1/2 -translate-y-1/2">
                <form className="flex flex-col" onSubmit={handleRegister}>
                  <label>Email</label>
                  <input
                    type="email"
                    value={registerInfo.email}
                    onChange={(e) => setRegisterInfo({ ...registerInfo, email: e.target.value })}
                    placeholder="Email"
                  ></input>
                  <label>Username</label>
                  <input
                    type="text"
                    value={registerInfo.username}
                    onChange={(e) => setRegisterInfo({ ...registerInfo, username: e.target.value })}
                    placeholder="Username"
                  ></input>
                  <label>Password</label>
                  <input
                    type="password"
                    value={registerInfo.password}
                    onChange={(e) => setRegisterInfo({ ...registerInfo, password: e.target.value })}
                    placeholder="Password"
                  ></input>
                  <label>First Name</label>
                  <input
                    type="text"
                    value={registerInfo.firstName}
                    onChange={(e) => setRegisterInfo({ ...registerInfo, firstName: e.target.value })}
                    placeholder="First Name"
                  ></input>
                  <label>Last Name</label>
                  <input
                    type="text"
                    value={registerInfo.lastName}
                    onChange={(e) => setRegisterInfo({ ...registerInfo, lastName: e.target.value })}
                    placeholder="Last Name"
                  ></input>
                  <button type="submit">Create Account</button>
                  <button type="button" onClick={handleReset}>
                    Reset
                  </button>
                </form>
              </div>
            )}
          </div>
        )}
      </div>
    </div>
  );
}
