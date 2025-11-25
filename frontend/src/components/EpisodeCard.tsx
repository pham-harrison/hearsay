type EpisodeCardProps = {
  podcast_id: string;
  podcast_name: string;
  episode_num: string;
  onClick: () => void;
};

export default function EpisodeCard({
  podcast_name,
  episode_num,
  onClick,
}: EpisodeCardProps) {
  return (
    <li className="bg-green-300 cursor-pointer" onClick={onClick}>
      {podcast_name} : Episode {episode_num}
    </li>
  );
}
