import { useState, useEffect } from "react";
import { useNavigate } from "react-router-dom";
type SearchType = "podcasts" | "users";

type SearchFilters = {
  name: string;
  genre: string;
  language: string;
  platform: string;
  year: string;
  host: string;
  guest: string;
};

const API_URL_BASE = import.meta.env.VITE_API_URL;

export default function SearchBar() {
  const [searchType, setSearchType] = useState<SearchType>("podcasts");
  const [showFilters, setShowFilters] = useState(false);
  const [genres, setGenres] = useState<string[]>([]);
  const [languages, setLanguages] = useState<string[]>([]);
  const [platforms, setPlatforms] = useState<string[]>([]);
  const [hosts, setHosts] = useState<string[]>([]);
  const [guests, setGuests] = useState<string[]>([]);
  const [filteredHosts, setFilteredHosts] = useState<string[]>([]);
  const [filteredGuests, setFilteredGuests] = useState<string[]>([]);
  const [searchFilters, setSearchFilters] = useState<SearchFilters>({
    name: "",
    genre: "",
    language: "",
    platform: "",
    year: "",
    host: "",
    guest: "",
  });

  const navigate = useNavigate();

  useEffect(() => {
    async function loadFilters() {
      try {
        const response: Response = await fetch(`${API_URL_BASE}/podcasts/filters`);
        const data = await response.json();
        setGenres(data.genres);
        setLanguages(data.languages);
        setPlatforms(data.platforms);
        setHosts(data.hosts);
        setGuests(data.guests);
        setFilteredHosts(data.hosts);
        setFilteredGuests(data.guests);
      } catch (error) {
        console.log("Failed to fetch filters", error);
      }
    }
    loadFilters();
  }, []);

  async function handleSearch() {
    const params = new URLSearchParams();
    params.append("type", searchType);

    if (searchType === "podcasts") {
      Object.entries(searchFilters).forEach(([filter, value]) => {
        if (value) {
          params.append(filter, value);
        }
      });
    } else {
      params.append("name", searchFilters.name);
    }
    navigate(`/results?${params.toString()}`);
  }

  function handleReset() {
    setSearchFilters({ name: "", genre: "", language: "", platform: "", year: "", host: "", guest: "" });
  }

  function handleHostSearch(e: React.ChangeEvent<HTMLInputElement>) {
    const value = e.target.value;
    searchFilters.host = value;

    if (value.trim() === "") {
      setFilteredHosts([]);
    } else {
      setFilteredHosts(hosts.filter((h) => h.toLowerCase().includes(value.toLowerCase())));
    }
  }

  function handleGuestSearch(e: React.ChangeEvent<HTMLInputElement>) {
    const value = e.target.value;
    searchFilters.guest = value;

    if (value.trim() === "") {
      setFilteredGuests([]);
    } else {
      setFilteredGuests(guests.filter((g) => g.toLowerCase().includes(value.toLowerCase())));
    }
  }

  return (
    <>
      <button className="border" onClick={handleSearch}>
        Search
      </button>
      <div>
        <select value={searchType} onChange={(e) => setSearchType(e.target.value as SearchType)}>
          <option value="podcasts">Podcasts</option>
          <option value="users">Users</option>
        </select>
        <input
          className="w-100 h-7 px-2"
          type="search"
          placeholder={`Search ${searchType} ${searchType === "users" ? "by username" : ""}`}
          value={searchFilters.name}
          onChange={(e) => setSearchFilters({ ...searchFilters, name: e.target.value })}
        />

        <button disabled={searchType === "users"} onClick={() => setShowFilters(!showFilters)}>
          Filters
        </button>
        <div className="relative">
          {showFilters && searchType === "podcasts" && (
            <div className="absolute bg-cyan-100">
              <label>Genre</label>
              <select
                value={searchFilters.genre}
                onChange={(e) => setSearchFilters({ ...searchFilters, genre: e.target.value })}
              >
                <option value="">Any</option>
                {genres.map((genre) => (
                  <option key={genre} value={genre}>
                    {genre}
                  </option>
                ))}
              </select>
              <label>Language</label>
              <select
                value={searchFilters.language}
                onChange={(e) => setSearchFilters({ ...searchFilters, language: e.target.value })}
              >
                <option value="">Any</option>
                {languages.map((language) => (
                  <option key={language} value={language}>
                    {language}
                  </option>
                ))}
              </select>
              <label>Platform</label>
              <select
                value={searchFilters.platform}
                onChange={(e) => setSearchFilters({ ...searchFilters, platform: e.target.value })}
              >
                <option value="">Any</option>
                {platforms.map((platform) => (
                  <option key={platform} value={platform}>
                    {platform}
                  </option>
                ))}
              </select>
              <label>Year</label>
              <input
                type="number"
                min={0}
                max={9999}
                value={searchFilters.year}
                onChange={(e) => setSearchFilters({ ...searchFilters, year: e.target.value })}
              />
              <label>Host</label>
              <input
                type="text"
                value={searchFilters.host}
                onChange={handleHostSearch}
                placeholder="Search for a host"
              />
              {searchFilters.host && (
                <ul>
                  {filteredHosts.slice(0, 3).map((host) => (
                    <li
                      key={host}
                      onClick={() => {
                        setSearchFilters({ ...searchFilters, host: host });
                        setFilteredHosts([]);
                      }}
                    >
                      {host}
                    </li>
                  ))}
                </ul>
              )}
              <label>Guest</label>
              <input
                type="text"
                value={searchFilters.guest}
                onChange={handleGuestSearch}
                placeholder="Search for a guest"
              />
              {searchFilters.guest && (
                <ul>
                  {filteredGuests.slice(0, 3).map((guest) => (
                    <li
                      key={guest}
                      onClick={() => {
                        setSearchFilters({ ...searchFilters, guest: guest });
                        setFilteredGuests([]);
                      }}
                    >
                      {guest}
                    </li>
                  ))}
                </ul>
              )}
              <button onClick={handleReset}>Reset</button>
            </div>
          )}
        </div>
      </div>
    </>
  );
}
