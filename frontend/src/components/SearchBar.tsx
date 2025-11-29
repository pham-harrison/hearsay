import { useState, useEffect } from "react";
import { useNavigate } from "react-router-dom";
import { Input } from "./ui/input";
import { Button } from "./ui/button";
import { Popover, PopoverContent, PopoverTrigger } from "@/components/ui/popover";
import { Select, SelectContent, SelectItem, SelectTrigger, SelectValue } from "@/components/ui/select";
import { FontAwesomeIcon } from "@fortawesome/react-fontawesome";
import { faMagnifyingGlass, faFilter } from "@fortawesome/free-solid-svg-icons";
import { Label } from "@radix-ui/react-label";
import { SelectGroup } from "@radix-ui/react-select";
import {
  Command,
  CommandDialog,
  CommandEmpty,
  CommandGroup,
  CommandInput,
  CommandItem,
  CommandList,
  CommandSeparator,
  CommandShortcut,
} from "@/components/ui/command";

type SearchType = "podcasts" | "users" | "episodes";

type SearchFilters = {
  name: string;
  genre: string;
  language: string;
  platform: string;
  year: string;
  host: string;
  guest: string;
};

type SearchBarProps = {
  searchType: "podcasts" | "users" | "episodes";
  onSearch: (filters: SearchFilters) => void;
  podcastID?: string;
};

const API_URL_BASE = import.meta.env.VITE_API_URL;

export default function SearchBar({ searchType, onSearch, podcastID }: SearchBarProps) {
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
  let placeholder = "";
  if (searchType === "podcasts") {
    placeholder = "Search podcasts";
  } else if (searchType === "users") {
    placeholder = "Search users by username";
  } else {
    placeholder = "Search episodes";
  }

  useEffect(() => {
    async function loadFilters() {
      try {
        let data;
        if (searchType === "podcasts") {
          const response = await fetch(`${API_URL_BASE}/podcasts/filters`);
          data = await response.json();
          setGenres(data.genres);
          setLanguages(data.languages);
          setPlatforms(data.platforms);
        } else if (searchType === "episodes") {
          const response = await fetch(`${API_URL_BASE}/podcasts/${podcastID}/episodes/filters`);
          data = await response.json();
        }
        if (data) {
          setHosts(data.hosts ?? []);
          setGuests(data.guests ?? []);
          setFilteredHosts([]);
          setFilteredGuests([]);
        }
      } catch (error) {
        console.error("Failed to fetch filters", error);
      }
    }
    loadFilters();
  }, [searchType, podcastID]);

  async function handleSearch() {
    if (onSearch) {
      onSearch(searchFilters);
      return;
    }
  }

  function handleKeyPress(e: React.KeyboardEvent<HTMLInputElement>) {
    if (e.key === "Enter") {
      handleSearch();
    }
  }

  function handleReset() {
    setSearchFilters({ name: "", genre: "", language: "", platform: "", year: "", host: "", guest: "" });
  }

  function handleHostSearch(e: React.ChangeEvent<HTMLInputElement>) {
    const value = e.target.value;
    setSearchFilters({ ...searchFilters, host: value });

    if (value.trim() === "") {
      setFilteredHosts([]);
    } else {
      setFilteredHosts(hosts.filter((h) => h.toLowerCase().includes(value.toLowerCase())));
    }
  }

  function handleGuestSearch(e: React.ChangeEvent<HTMLInputElement>) {
    const value = e.target.value;
    setSearchFilters({ ...searchFilters, guest: value });

    if (value.trim() === "") {
      setFilteredGuests([]);
    } else {
      setFilteredGuests(guests.filter((g) => g.toLowerCase().includes(value.toLowerCase())));
    }
  }

  return (
    <>
      <div className="relative flex items-center w-full max-w-lg">
        <Button
          className="absolute top-1/2 transform -translate-y-1/2 bg-transparent hover:bg-transparent cursor-pointer"
          onClick={handleSearch}
        >
          <FontAwesomeIcon icon={faMagnifyingGlass} className="pt-0.25 text-lg" />
        </Button>
        <Input
          className="lg:w-100 md:w-75 sm:w-65 h-9 pl-11 pr-8 py-4 text-base"
          type="search"
          value={searchFilters.name}
          onChange={(e) => setSearchFilters({ ...searchFilters, name: e.target.value })}
          placeholder={placeholder}
          onKeyDown={handleKeyPress}
        ></Input>

        <Popover>
          <PopoverTrigger asChild>
            <Button
              className="absolute right-1 top-1/2 -translate-y-1/2 rounded-full p-0 w-7 h-7 cursor-pointer disabled:cursor-not-allowed"
              disabled={searchType === "users"}
            >
              <FontAwesomeIcon icon={faFilter} />
            </Button>
          </PopoverTrigger>
          {searchType === "podcasts" && (
            <PopoverContent className="grid grid-cols-3 w-lg gap-4">
              <div className="flex flex-col gap-1">
                <Label>Genre</Label>
                <Select
                  value={searchFilters.genre}
                  onValueChange={(value) => setSearchFilters({ ...searchFilters, genre: value !== "any" ? value : "" })}
                >
                  <SelectTrigger>
                    <SelectValue placeholder="Any" />
                  </SelectTrigger>
                  <SelectContent>
                    <SelectGroup>
                      <SelectItem
                        className="data-highlighted:bg-primary data-highlighted:text-primary-foreground"
                        key="any"
                        value="any"
                      >
                        Any
                      </SelectItem>
                      {genres.map((genre) => (
                        <SelectItem
                          className="data-highlighted:bg-primary data-highlighted:text-primary-foreground"
                          key={genre}
                          value={genre}
                        >
                          {genre}
                        </SelectItem>
                      ))}
                    </SelectGroup>
                  </SelectContent>
                </Select>
              </div>
              <div className="flex flex-col gap-1">
                <Label>Language</Label>
                <Select
                  value={searchFilters.language}
                  onValueChange={(value) =>
                    setSearchFilters({ ...searchFilters, language: value !== "any" ? value : "" })
                  }
                >
                  <SelectTrigger>
                    <SelectValue placeholder="Any" />
                  </SelectTrigger>
                  <SelectContent>
                    <SelectGroup>
                      <SelectItem
                        className="data-highlighted:bg-primary data-highlighted:text-primary-foreground"
                        key="any"
                        value="any"
                      >
                        Any
                      </SelectItem>
                      {languages.map((language) => (
                        <SelectItem
                          className="data-highlighted:bg-primary data-highlighted:text-primary-foreground"
                          key={language}
                          value={language}
                        >
                          {language}
                        </SelectItem>
                      ))}
                    </SelectGroup>
                  </SelectContent>
                </Select>
              </div>
              <div className="flex flex-col gap-1">
                <Label>Platform</Label>
                <Select
                  value={searchFilters.platform}
                  onValueChange={(value) =>
                    setSearchFilters({ ...searchFilters, platform: value !== "any" ? value : "" })
                  }
                >
                  <SelectTrigger>
                    <SelectValue placeholder="Any" />
                  </SelectTrigger>
                  <SelectContent>
                    <SelectGroup>
                      <SelectItem
                        className="data-highlighted:bg-primary data-highlighted:text-primary-foreground"
                        key="any"
                        value="any"
                      >
                        Any
                      </SelectItem>
                      {platforms.map((platform) => (
                        <SelectItem
                          className="data-highlighted:bg-primary data-highlighted:text-primary-foreground"
                          key={platform}
                          value={platform}
                        >
                          {platform}
                        </SelectItem>
                      ))}
                    </SelectGroup>
                  </SelectContent>
                </Select>
              </div>
              <div className="flex flex-col gap-1">
                <Label>Year</Label>
                <Input
                  className="w-24"
                  type="number"
                  min={0}
                  max={9999}
                  placeholder="Any"
                  value={searchFilters.year}
                  onChange={(e) => setSearchFilters({ ...searchFilters, year: e.target.value })}
                />
              </div>
              <div className="relative">
                <Label>Host</Label>
                <Input
                  type="search"
                  className="mt-1"
                  value={searchFilters.host}
                  onChange={handleHostSearch}
                  placeholder="Any"
                />
                {filteredHosts.length > 0 && (
                  <div className="absolute">
                    <Command className="rounded-sm w-34 border p-1">
                      <CommandList className="no-scrollbar">
                        {filteredHosts.map((host) => (
                          <CommandItem
                            className="data-[selected=true]:bg-primary data-[selected=true]:text-white"
                            key={host}
                            onSelect={() => {
                              setSearchFilters({ ...searchFilters, host: host });
                              setFilteredHosts([]);
                            }}
                          >
                            {host}
                          </CommandItem>
                        ))}
                      </CommandList>
                    </Command>
                  </div>
                )}
              </div>
              <div className="relative">
                <Label>Guest</Label>
                <Input
                  type="search"
                  className="mt-1"
                  value={searchFilters.guest}
                  onChange={handleGuestSearch}
                  placeholder="Any"
                />
                {filteredGuests.length > 0 && (
                  <div className="absolute">
                    <Command className="rounded-sm border p-1">
                      <CommandList className="no-scrollbar w-34">
                        {filteredGuests.map((guest) => (
                          <CommandItem
                            className="data-[selected=true]:bg-primary data-[selected=true]:text-white"
                            key={guest}
                            onSelect={() => {
                              setSearchFilters({ ...searchFilters, guest: guest });
                              setFilteredGuests([]);
                            }}
                          >
                            {guest}
                          </CommandItem>
                        ))}
                      </CommandList>
                    </Command>
                  </div>
                )}
              </div>
              <div></div>
              <div></div>
              <Button className="mt-2 w-15 justify-self-end" onClick={handleReset}>
                Reset
              </Button>
            </PopoverContent>
          )}

          {searchType === "episodes" && (
            <PopoverContent className="grid grid-cols-3 w-lg gap-4">
              <div className="flex flex-col">
                <Label>Year</Label>
                <Input
                  className="w-24"
                  type="number"
                  min={0}
                  max={9999}
                  placeholder="Any"
                  value={searchFilters.year}
                  onChange={(e) => setSearchFilters({ ...searchFilters, year: e.target.value })}
                />
              </div>
              <div className="relative">
                <Label>Host</Label>
                <Input type="search" value={searchFilters.host} onChange={handleHostSearch} placeholder="Any" />
                {filteredHosts.length > 0 && (
                  <div className="absolute">
                    <Command>
                      <CommandList>
                        {filteredHosts.map((host) => (
                          <CommandItem
                            key={host}
                            onSelect={() => {
                              setSearchFilters({ ...searchFilters, host: host });
                              setFilteredHosts([]);
                            }}
                          >
                            {host}
                          </CommandItem>
                        ))}
                      </CommandList>
                    </Command>
                  </div>
                )}
              </div>
              <div className="relative">
                <Label>Guest</Label>
                <Input type="search" value={searchFilters.guest} onChange={handleGuestSearch} placeholder="Any" />
                {filteredGuests.length > 0 && (
                  <div className="absolute">
                    <Command>
                      <CommandList>
                        {filteredGuests.map((guest) => (
                          <CommandItem
                            key={guest}
                            onSelect={() => {
                              setSearchFilters({ ...searchFilters, guest: guest });
                              setFilteredGuests([]);
                            }}
                          >
                            {guest}
                          </CommandItem>
                        ))}
                      </CommandList>
                    </Command>
                  </div>
                )}
              </div>
              <div></div>
              <div></div>
              <Button className="mt-2 w-15 justify-self-end" onClick={handleReset}>
                Reset
              </Button>
            </PopoverContent>
          )}
        </Popover>
      </div>
    </>
  );
}
