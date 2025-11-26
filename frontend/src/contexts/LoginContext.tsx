import React, { createContext, useEffect, useState } from "react";
import { jwtDecode } from "jwt-decode";

type Login = {
  loggedIn: boolean;
  setLoggedIn: (value: boolean) => void;
  userID: string;
  setUserID: (value: string) => void;
  onLogout: () => void;
  token: string | null;
  setToken: (value: string) => void;
};

export const LoginContext = createContext<Login>({
  loggedIn: false,
  setLoggedIn: () => {},
  userID: "",
  setUserID: () => {},
  onLogout: () => {},
  token: null,
  setToken: () => {},
});

export function LoginProvider({ children }: { children: React.ReactNode }) {
  const [loggedIn, setLoggedIn] = useState<boolean>(false);
  const [userID, setUserID] = useState<string>("");
  const [token, setToken] = useState<string | null>(null);

  useEffect(() => {
    const token = localStorage.getItem("jwt");
    if (token) {
      const decodedToken = jwtDecode(token);
      if (decodedToken.exp && decodedToken.sub && Date.now() < decodedToken.exp * 1000) {
        setUserID(decodedToken.sub);
        setLoggedIn(true);
        setToken(token);
      }
    }
  }, []);

  function handleLogout() {
    localStorage.removeItem("jwt");
    setLoggedIn(false);
    setUserID("");
  }

  return (
    <LoginContext.Provider
      value={{ loggedIn, setLoggedIn, userID, setUserID, onLogout: handleLogout, token, setToken }}
    >
      {children}
    </LoginContext.Provider>
  );
}
