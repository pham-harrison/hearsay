import { Avatar, AvatarFallback, AvatarImage } from "@/components/ui/avatar";
import {
  Item,
  ItemActions,
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
        className="w-50 h-65 flex items-center cursor-pointer transition-transform hover:scale-102 active:scale-98 duration-150"
        onClick={onClick}
      >
        <div className="">
          <ItemMedia className="mb-2">
            <Avatar className="size-42">
              <AvatarImage src={minimalistAvatarM} />
              <AvatarFallback>{username}</AvatarFallback>
            </Avatar>
          </ItemMedia>
          <ItemContent>
            <ItemTitle className="font-bold text-xl">{username}</ItemTitle>
            <ItemDescription className="break-all">{}</ItemDescription>
          </ItemContent>
        </div>
      </Item>
    </div>
  );
}
