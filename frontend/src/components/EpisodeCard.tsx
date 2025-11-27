import { useContext } from "react";
import { useParams } from "react-router-dom";
import { LoginContext } from "../contexts/LoginContext";

type EpisodeCardProps = {
  podcast_id: string;
  podcast_name: string;
  episode_num: string;
  onClick: () => void;
  onDelete: () => void;
};

export default function EpisodeCard({
  podcast_name,
  episode_num,
  onClick,
  onDelete,
}: EpisodeCardProps) {
  const { loggedIn, userID } = useContext(LoginContext);
  const urlID = useParams().userID;

  return (
    <li className="bg-grey-300 cursor-pointer" onClick={onClick}>
      - {podcast_name} : Episode {episode_num}{" "}
      {loggedIn && userID === urlID && (
        <button
          className="bg-red-500 hover:bg-red-700 text-white font-bold py-2 px-4 rounded"
          onClick={(e) => {
            e.stopPropagation();
            onDelete();
          }}
        >
          Delete Episode
        </button>
      )}
    </li>
  );
}
