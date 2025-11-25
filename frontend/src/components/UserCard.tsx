type UserCardProps = {
  id: string;
  username: string;
  first_name: string;
  last_name: string;
  bio: string;
  onClick: () => void;
};

export default function UserCard({
  id,
  username,
  first_name,
  last_name,
  bio,
  onClick,
}: UserCardProps) {
  return (
    <div className="bg-green-200 cursor-pointer" onClick={onClick}>
      {username}
    </div>
  );
}
