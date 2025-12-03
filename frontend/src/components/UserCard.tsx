import { Avatar, AvatarFallback, AvatarImage } from "@/components/ui/avatar";
import {
  Item,
  ItemContent,
  ItemDescription,
  ItemMedia,
  ItemTitle,
} from "@/components/ui/item";
import minimalistAvatarM from "../assets/minimalistAvatarM.jpg";

type UserCardProps = {
  username: string;
  bio: string;
  onClick: () => void;
};

export default function UserCard({ username, bio, onClick }: UserCardProps) {
  return (
    <div className="">
      <Item
        variant="outline"
        className="w-50 h-70 flex items-center cursor-pointer transition-transform hover:scale-102 active:scale-98 duration-150"
        onClick={onClick}
      >
        <div>
          <ItemMedia className="">
            <Avatar className="size-42 shrink-0 mb-2">
              <AvatarImage src={minimalistAvatarM} />
              <AvatarFallback>{username}</AvatarFallback>
            </Avatar>
          </ItemMedia>
          <ItemTitle className="font-bold text-xl shrink-0">
            {username}
          </ItemTitle>
        </div>
        <ItemContent>
          <div className="flex flex-col overflow-hidden">
            <ItemDescription className="truncate break-words overflow-hidden">
              {bio ? bio : <span className="italic">No bio . . .</span>}
            </ItemDescription>
          </div>
        </ItemContent>
      </Item>
    </div>
  );
}
