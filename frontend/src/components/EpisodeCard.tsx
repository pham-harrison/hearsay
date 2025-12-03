import {
  Item,
  ItemContent,
  ItemDescription,
  ItemMedia,
  ItemTitle,
} from "@/components/ui/item";
import episode from "../assets/episode_image.png";
import { useNavigate } from "react-router-dom";

type EpisodeCardProps = {
  podcastId: string;
  episodeNum: string;
  episodeName: string | null;
  description: string;
};

export default function EpisodeCard({
  podcastId,
  episodeNum,
  episodeName,
  description,
}: EpisodeCardProps) {
  const navigate = useNavigate();
  return (
    <div
      className="
        shrink-0 cursor-pointer
        transition-all duration-150
        hover:scale-104
        activ:scale-98
        hover:bg-gradient-to-r
        hover:from-fuchsia-300 hover:to-purple-800 rounded-lg
      "
    >
      <Item
        className="
         shrink-0 cursor-pointer
        transition-all duration-150
        hover:scale-98
        activ:scale-98
        bg-card border border-2 border-bg-primary
      "
        onClick={() =>
          navigate(`/podcasts/${podcastId}/episodes/${episodeNum}`)
        }
      >
        <ItemMedia>
          <img
            className="rounded-sm"
            src={episode}
            alt={podcastId + " " + episodeNum}
          />{" "}
        </ItemMedia>
        <ItemContent>
          <ItemTitle className="hover:underline">
            {episodeName ? episodeName : "Untitled"}
          </ItemTitle>
          <ItemDescription>
            <div className="flex flex-col">
              <h1>{"Episode: " + episodeNum}</h1>
              <div>{description}</div>
            </div>
          </ItemDescription>
        </ItemContent>
      </Item>
    </div>
  );
}
