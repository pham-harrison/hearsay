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
}: PlaylistCardProps) {
  return (
    <div className="bg-purple-900 cursor-pointer" onClick={onClick}>
      {name} : {description}{" "}
    </div>
  );
}
