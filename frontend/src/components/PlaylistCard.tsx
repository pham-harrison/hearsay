type PlaylistCardProps = {
  user_id: string;
  name: string;
  description: string;
  onClick: () => void;
};

export default function PlaylistCard({
  user_id,
  name,
  description,
  onClick,
}: PlaylistCardProps) {
  return (
    <div className="bg-green-300 cursor-pointer" onClick={onClick}>
      {name}
    </div>
  );
}
