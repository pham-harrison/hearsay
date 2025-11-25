type ReviewCardProps = {
  rating: string;
  comment: string;
  created_at: string;
  onClick: () => void;
};

export default function PlaylistCard({
  rating,
  comment,
  created_at,
  onClick,
}: ReviewCardProps) {
  return (
    <div className="bg-green-300 cursor-pointer" onClick={onClick}>
      {rating} : {comment} : {created_at}
    </div>
  );
}
