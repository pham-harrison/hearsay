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
  return (
    <div className="bg-green-300 cursor-pointer" onClick={onClick}>
      {name} : {description}{" "}
      <button
        className="bg-yellow-500 hover:bg-yellow-700 text-white font-bold py-2 px-4 rounded"
        onClick={(e) => {
          e.stopPropagation();
          onDelete();
        }}
      >
        Edit
      </button>
      <button
        className="bg-red-500 hover:bg-red-700 text-white font-bold py-2 px-4 rounded"
        onClick={(e) => {
          e.stopPropagation();
          onDelete();
        }}
      >
        Delete
      </button>
    </div>
  );
}
