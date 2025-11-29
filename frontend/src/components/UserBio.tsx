import { ClipboardPenIcon } from "lucide-react";
import { Button } from "@/components/ui/button";
import {
  Popover,
  PopoverContent,
  PopoverTrigger,
} from "@/components/ui/popover";
import { Textarea } from "@/components/ui/textarea";

type BioProps = {
  bio: string;
  onBioChange: (newBio: string) => void;
  onConfirm: (e: React.FormEvent) => void;
};

const UserBio = ({ bio, onBioChange, onConfirm }: BioProps) => {
  return (
    <Popover>
      <PopoverTrigger asChild>
        <Button variant="outline" size="icon">
          <ClipboardPenIcon />
          <span className="sr-only">Update bio</span>
        </Button>
      </PopoverTrigger>
      <PopoverContent className="w-80">
        <div className="grid gap-2">
          <div className="font-medium">Update bio</div>
          <Textarea
            onChange={(e) => onBioChange(e.target.value)}
            placeholder="Enter your new bio here"
            value={bio}
            className="max-h-56"
          />
          <div className="grid w-full grid-cols-2 gap-2">
            <Button size="sm" onClick={onConfirm}>
              Confirm
            </Button>
            <Button variant="secondary" size="sm">
              Cancel
            </Button>
          </div>
        </div>
      </PopoverContent>
    </Popover>
  );
};

export default UserBio;
