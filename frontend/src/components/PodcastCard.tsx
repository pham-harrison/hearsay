type PodcastCardProps = {
  podcast_id: string;
  name: string;
  description: string;
  release_date: string;
  genres: string;
  onClick: () => void;
};

export default function PodcastCard({
  podcast_id,
  name,
  description,
  release_date,
  genres,
  onClick,
}: PodcastCardProps) {
  return (
    <div className="bg-red-900 cursor-pointer" onClick={onClick}>
      {name}
    </div>
  );
}
