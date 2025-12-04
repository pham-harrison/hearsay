import "./App.css";
import { BrowserRouter, Routes, Route } from "react-router-dom";
import NavBar from "./components/NavBar";
import Home from "./pages/Home";
import Results from "./pages/Results";
import Podcast from "./pages/Podcast";
import { LoginProvider } from "./contexts/LoginContext";
import { Toaster } from "./components/ui/sonner";
import Profile from "./pages/Profile";
import Episode from "./pages/Episode";
import ScrollToTop from "./components/ScrollToTop";

function App() {
  return (
    <BrowserRouter>
      <LoginProvider>
        <ScrollToTop />
        <Toaster position="top-center" />
        <div className="flex flex-col min-h-screen">
          <NavBar />
          <Routes>
            <Route path="/" element={<Home />} />
            <Route path="/results" element={<Results />} />
            <Route path="/podcasts/:podcastID" element={<Podcast />} />
            <Route path="/users/:userID" element={<Profile />} />
            <Route path="/podcasts/:podcastID/episodes/:episodeNum" element={<Episode />} />
          </Routes>
        </div>
      </LoginProvider>
    </BrowserRouter>
  );
}

export default App;
