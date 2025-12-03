import { useState } from "react";
import { ClipboardPenIcon } from "lucide-react";
import { Button } from "@/components/ui/button";
import {
  Popover,
  PopoverContent,
  PopoverTrigger,
} from "@/components/ui/popover";
import { Textarea } from "@/components/ui/textarea";
import type React from "react";

type BioProps = {
  bio: string;
  onBioChange: (newBio: string) => void;
  onConfirm: (e: React.FormEvent) => void;
};

export default function UserBio({ bio, onBioChange, onConfirm }: BioProps) {
  const [open, setOpen] = useState(false);
  const handleClose = () => {
    setOpen(false);
  };

  return (
    <Popover open={open} onOpenChange={setOpen}>
      <PopoverTrigger asChild onClick={() => setOpen(true)}>
        <Button className="w-10 rounded-full" variant="outline" size="icon">
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
            <Button
              size="sm"
              onClick={(e) => {
                onConfirm(e);
                handleClose();
              }}
            >
              Confirm
            </Button>
            <Button variant="secondary" size="sm" onClick={handleClose}>
              Cancel
            </Button>
          </div>
        </div>
      </PopoverContent>
    </Popover>
  );
}
