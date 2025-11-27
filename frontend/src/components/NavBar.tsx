import React, { useState, useEffect, useContext } from "react";
import { useNavigate } from "react-router-dom";
import microphoneIcon from "../assets/microphone.png";
import { LoginContext } from "../contexts/LoginContext";
import { jwtDecode } from "jwt-decode";
import {
  Dialog,
  DialogContent,
  DialogDescription,
  DialogHeader,
  DialogTitle,
  DialogTrigger,
} from "@/components/ui/dialog";
import { Button } from "@/components/ui/button";
import { Label } from "@/components/ui/label";
import { Input } from "@/components/ui/input";
import { Tabs, TabsContent, TabsList, TabsTrigger } from "@/components/ui/tabs";
import { Select, SelectContent, SelectItem, SelectTrigger, SelectValue } from "@/components/ui/select";
import SearchBar from "./SearchBar";

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

type SearchType = "podcasts" | "users" | "episodes";

export default function NavBar() {
  const navigate = useNavigate();
  const [searchType, setSearchType] = useState<SearchType>("podcasts");
  const [activeModal, setActiveModal] = useState<activeModal>(null);
  const { loggedIn, setLoggedIn, setUserID, onLogout, setToken } = useContext(LoginContext);

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
      localStorage.setItem("jwt", data.access_token);
      const decodedToken = jwtDecode(data.access_token);
      if (decodedToken.sub) setUserID(decodedToken.sub);
      setLoggedIn(true);
      setActiveModal(null);
      setToken(data.access_token);
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
    <div className="flex bg-popover h-16 top-0 left-0 justify-between items-center pr-3">
      <div>
        <img src={microphoneIcon} className="w-15 h-14.5 cursor-pointer" onClick={() => navigate("/")} />
      </div>
      <div className="flex items-center">
        <Select value={searchType} onValueChange={(value: SearchType) => setSearchType(value)}>
          <SelectTrigger>
            <SelectValue placeholder={searchType} />
          </SelectTrigger>
          <SelectContent>
            <SelectItem value="podcasts">Podcasts</SelectItem>
            <SelectItem value="users">Users</SelectItem>
          </SelectContent>
        </Select>
        <SearchBar
          searchType={searchType}
          onSearch={(searchFilters) => {
            const params = new URLSearchParams();
            params.append("type", searchType);
            if (searchType === "podcasts") {
              Object.entries(searchFilters).forEach(([filter, value]) => {
                if (value) {
                  params.append(filter, value);
                }
              });
            }
            navigate(`/results?${params.toString()}`);
          }}
        />
      </div>
      <div className="relative">
        {loggedIn ? (
          <div>
            <button
              onClick={() => {
                onLogout();
              }}
            >
              User
            </button>
          </div>
        ) : (
          <Dialog>
            <DialogTrigger asChild>
              <Button variant="outline">Log in/Sign up</Button>
            </DialogTrigger>
            <DialogContent className="sm:max-w-[425px]">
              <DialogDescription></DialogDescription>
              <Tabs defaultValue="login">
                <TabsList className="w-full bg-background rounded-none border-b p-0 mt-3">
                  <TabsTrigger
                    value="login"
                    className="bg-background data-[state=active]:border-primary dark:data-[state=active]:border-primary h-full rounded-none border-0 border-b-2 border-transparent data-[state=active]:shadow-none cursor-pointer"
                  >
                    Log in
                  </TabsTrigger>
                  <TabsTrigger
                    value="signup"
                    className="bg-background data-[state=active]:border-primary dark:data-[state=active]:border-primary h-full rounded-none border-0 border-b-2 border-transparent data-[state=active]:shadow-none cursor-pointer"
                  >
                    Sign up
                  </TabsTrigger>
                </TabsList>
                <TabsContent value="login">
                  <DialogHeader>
                    <DialogTitle className="text-xl mb-3">Log in</DialogTitle>
                  </DialogHeader>
                  <form className="flex flex-col gap-4" onSubmit={handleLogin}>
                    <Label className="text-sm">Username</Label>
                    <Input
                      type="text"
                      onChange={(e) => setLoginInfo({ ...loginInfo, username: e.target.value })}
                    ></Input>
                    <Label>Password</Label>
                    <Input
                      type="password"
                      onChange={(e) => setLoginInfo({ ...loginInfo, password: e.target.value })}
                    ></Input>
                    <Button className="cursor-pointer" type="submit">
                      Log In
                    </Button>
                  </form>
                </TabsContent>
                <TabsContent value="signup">
                  <DialogHeader>
                    <DialogTitle className="text-xl mb-3">Sign up</DialogTitle>
                  </DialogHeader>
                  <form className="flex flex-col gap-4" onSubmit={handleRegister}>
                    <Label>Email</Label>
                    <Input
                      type="email"
                      value={registerInfo.email}
                      onChange={(e) =>
                        setRegisterInfo({
                          ...registerInfo,
                          email: e.target.value,
                        })
                      }
                    ></Input>
                    <Label>Username</Label>
                    <Input
                      type="text"
                      value={registerInfo.username}
                      onChange={(e) =>
                        setRegisterInfo({
                          ...registerInfo,
                          username: e.target.value,
                        })
                      }
                    ></Input>
                    <Label>Password</Label>
                    <Input
                      type="password"
                      value={registerInfo.password}
                      onChange={(e) =>
                        setRegisterInfo({
                          ...registerInfo,
                          password: e.target.value,
                        })
                      }
                    ></Input>
                    <div className="flex gap-2">
                      <div className="flex flex-col gap-3">
                        <Label>First Name</Label>
                        <Input
                          type="text"
                          value={registerInfo.firstName}
                          onChange={(e) =>
                            setRegisterInfo({
                              ...registerInfo,
                              firstName: e.target.value,
                            })
                          }
                        ></Input>
                      </div>
                      <div className="flex flex-col gap-3">
                        <Label>Last Name</Label>
                        <Input
                          type="text"
                          value={registerInfo.lastName}
                          onChange={(e) =>
                            setRegisterInfo({
                              ...registerInfo,
                              lastName: e.target.value,
                            })
                          }
                        ></Input>
                      </div>
                    </div>
                    <div className="flex justify-between">
                      <Button className="cursor-pointer" type="button" onClick={handleReset}>
                        Reset
                      </Button>
                      <Button className="cursor-pointer" type="submit">
                        Create Account
                      </Button>
                    </div>
                  </form>
                </TabsContent>
              </Tabs>
            </DialogContent>
          </Dialog>
        )}
      </div>
    </div>
  );
}
