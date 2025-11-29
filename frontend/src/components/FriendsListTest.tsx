import { Dialog, DialogTrigger } from "@/components/ui/dialog";
import { Avatar, AvatarFallback, AvatarImage } from "@/components/ui/avatar";
import { Button } from "@/components/ui/button";
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
  id: string;
  username: string;
  first_name: string;
  last_name: string;
  bio: string;
  onClick: () => void;
};

export default function FriendsListTest({
  id,
  username,
  first_name,
  last_name,
  bio,
  onClick,
}: UserCardProps) {
  return (
    <Dialog>
      <DialogTrigger asChild>
        <Button variant="outline">Open Dialog</Button>
      </DialogTrigger>
      <Item variant="outline" onClick={onClick}>
        <ItemMedia>
          <Avatar className="size-10">
            <AvatarImage src={minimalistAvatarM} />
            <AvatarFallback>ER</AvatarFallback>
          </Avatar>
        </ItemMedia>
        <ItemContent>
          <ItemTitle>{username}</ItemTitle>
          <ItemDescription className="break-all">{bio}</ItemDescription>
        </ItemContent>
        <ItemActions>
          {/* Stop propation thingy here so it doesn't navigate to user instead (or both)
          <Button
            size="icon-sm"
            variant="outline"
            className="rounded-full"
            aria-label="Remove friend"
          >
            <CircleX />
          </Button>
          */}
        </ItemActions>
      </Item>
    </Dialog>
  );
}
