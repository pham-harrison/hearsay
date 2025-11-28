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
import avatar from "../assets/minimalistAvatarM.jpg";
import logo from "../assets/hearsayLogo.png";
import { UserIcon, LogOutIcon } from "lucide-react";
import {
  DropdownMenu,
  DropdownMenuContent,
  DropdownMenuGroup,
  DropdownMenuItem,
  DropdownMenuTrigger,
} from "@/components/ui/dropdown-menu";
import { toast } from "sonner";

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
  const { loggedIn, setLoggedIn, userID, setUserID, onLogout, setToken } = useContext(LoginContext);

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

  async function login(username: string, password: string) {
    try {
      const response = await fetch(`${API_URL_BASE}/users/login`, {
        method: "POST",
        headers: { "Content-Type": "application/json" },
        body: JSON.stringify({ username, password }),
      });
      const data = await response.json();
      if (!response.ok) {
        toast.error(data.detail);
        return;
      }
      localStorage.setItem("jwt", data.access_token);
      const decodedToken = jwtDecode(data.access_token);
      if (decodedToken.sub) setUserID(decodedToken.sub);
      setLoggedIn(true);
      setToken(data.access_token);
    } catch (error) {
      console.log("Failed to log in", error);
    }
  }

  async function handleLogin(e: React.FormEvent) {
    e.preventDefault();
    if (!areAllFieldsFilled(loginInfo)) {
      toast.error("All fields must be filled");
      return;
    }
    handleReset();
    setLoginInfo({ username: "", password: "" });
    login(loginInfo.username, loginInfo.password);
  }

  function areAllFieldsFilled(object: Record<string, string>) {
    return Object.values(object).every((value) => value);
  }

  async function handleRegister(e: React.FormEvent) {
    e.preventDefault();
    if (!areAllFieldsFilled(registerInfo)) {
      toast.error("All fields must be filled");
      return;
    }
    if (!registerInfo.email.endsWith(".com")) {
      toast.error("Email must end with .com");
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
        toast.error(data.detail);
        return;
      }
      login(registerInfo.username, registerInfo.password);
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
    <div className="flex bg-popover h-16 top-0 left-0 justify-between items-center px-3">
      <Button className="p-0 bg-white cursor-pointer flex justify-center items-center" onClick={() => navigate("/")}>
        <img className="w-30 rounded-full" src={logo} />
      </Button>
      <div className="flex justify-center items-center">
        <Select value={searchType} onValueChange={(value: SearchType) => setSearchType(value)}>
          <SelectTrigger className="cursor-pointer font-medium">
            <SelectValue placeholder={searchType} />
          </SelectTrigger>
          <SelectContent>
            <SelectItem
              className="cursor-pointer data-highlighted:bg-primary data-highlighted:text-primary-foreground"
              value="podcasts"
            >
              Podcasts
            </SelectItem>
            <SelectItem
              className="cursor-pointer data-highlighted:bg-primary data-highlighted:text-primary-foreground"
              value="users"
            >
              Users
            </SelectItem>
          </SelectContent>
        </Select>
        <div className="px-2"></div>
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
            } else if (searchType === "users") {
              params.append("name", searchFilters.name);
            }
            navigate(`/results?${params.toString()}`);
          }}
        />
      </div>
      <div className="relative">
        {loggedIn ? (
          <div className="flex relative">
            <DropdownMenu>
              <DropdownMenuTrigger asChild>
                <img
                  src={avatar}
                  className="w-10 rounded-full cursor-pointer hover:scale-105 transition-all duration-200 shrink-0"
                ></img>
              </DropdownMenuTrigger>
              <DropdownMenuContent className="absolute transform -translate-x-25">
                <DropdownMenuGroup>
                  <DropdownMenuItem
                    className="cursor-pointer data-highlighted:bg-primary data-highlighted:text-primary-foreground"
                    onClick={() => navigate(`/users/${userID}`)}
                  >
                    <UserIcon></UserIcon>
                    <span className="text-popover-foreground">View Account</span>
                  </DropdownMenuItem>
                  <DropdownMenuItem
                    className="cursor-pointer data-highlighted:bg-primary data-highlighted:text-primary-foreground"
                    onClick={() => onLogout()}
                  >
                    <LogOutIcon></LogOutIcon>
                    <span className="text-popover-foreground">Sign out</span>
                  </DropdownMenuItem>
                </DropdownMenuGroup>
              </DropdownMenuContent>
            </DropdownMenu>
          </div>
        ) : (
          <Dialog>
            <DialogTrigger asChild>
              <Button className="cursor-pointer hover:bg-primary! hover:text-primary-foreground!" variant="outline">
                Log in/Sign up
              </Button>
            </DialogTrigger>
            <DialogContent className="sm:max-w-[425px]">
              <DialogDescription></DialogDescription>
              <Tabs defaultValue="login">
                <TabsList className="w-full bg-background rounded-none border-b p-0 mt-1">
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
