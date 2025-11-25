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
  return (
    <li className="bg-green-300 cursor-pointer" onClick={onClick}>
      {podcast_name} : Episode {episode_num}{" "}
      <button
        className="bg-red-500 hover:bg-red-700 text-white font-bold py-2 px-4 rounded"
        onClick={(e) => {
          e.stopPropagation();
          onDelete();
        }}
      >
        Delete
      </button>
    </li>
  );
}
