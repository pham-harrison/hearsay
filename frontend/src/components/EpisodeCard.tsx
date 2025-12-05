import { Item, ItemContent, ItemDescription, ItemMedia, ItemTitle } from "@/components/ui/item";
import episode from "../assets/episode_image.png";
import { useNavigate } from "react-router-dom";

type EpisodeCardProps = {
  podcastId: string;
  episodeNum: string;
  episodeName: string | null;
  description: string;
  duration: number;
  releaseDate: string;
};

export default function EpisodeCard({ podcastId, episodeNum, episodeName, description }: EpisodeCardProps) {
  const navigate = useNavigate();
  return (
    <div>
      <Item
        className="
        shrink-0 cursor-pointer
        transition-all duration-150
        hover:scale-102
        active:scale-98
        bg-gradient-to-br from-fuchsia-300 to-purple-700
        h-60
      "
        onClick={() => navigate(`/podcasts/${podcastId}/episodes/${episodeNum}`)}
      >
        <ItemMedia>
          <img className="rounded-sm" src={episode} alt={podcastId + " " + episodeNum} />{" "}
        </ItemMedia>
        <ItemContent>
          <ItemTitle className="hover:underline text-3xl text-gray-900 tracking-tight font-bold">
            {episodeName ? episodeName : "Untitled"}
          </ItemTitle>
          <ItemDescription>
            <div className="flex flex-col">
              <h1 className="text-gray-900 text-lg font-bold">{"Episode: " + episodeNum}</h1>
              <div className="text-md text-gray-900">{description}</div>
            </div>
          </ItemDescription>
        </ItemContent>
      </Item>
    </div>
  );
}
