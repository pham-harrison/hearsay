import { useContext } from "react";
import { useParams } from "react-router-dom";
import { LoginContext } from "../contexts/LoginContext";

type PlaylistCardProps = {
  name: string;
  description: string;
  onClick: () => void;
  onDelete: () => void;
};

export default function PlaylistCard({
  name,
  description,
  onClick,
  onDelete,
}: PlaylistCardProps) {
  const { loggedIn, userID } = useContext(LoginContext);
  const urlID = useParams().userID;

  return (
    <div className="bg-green-300 cursor-pointer" onClick={onClick}>
      {name} : {description}{" "}
      {loggedIn && userID === urlID && (
        <button
          className="bg-red-500 hover:bg-red-700 text-white font-bold py-2 px-4 rounded"
          onClick={(e) => {
            e.stopPropagation();
            onDelete();
          }}
        >
          Delete
        </button>
      )}
    </div>
  );
}
