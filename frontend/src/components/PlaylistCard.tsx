type PlaylistCardProps = {
  name: string;
  description: string;
  onClick: () => void;
};

export default function PlaylistCard({
  name,
  description,
  onClick,
}: PlaylistCardProps) {
  return (
    <div className="bg-green-300 cursor-pointer" onClick={onClick}>
      {name} : {description}
    </div>
  );
}
