import { Card, CardContent, CardHeader, CardDescription, CardTitle, CardFooter } from "@/components/ui/card";
import podcast from "../assets/minimalistMicrophone.jpg";
import { Button } from "./ui/button";
import dateFormat from "@/utils/dateFormat";

type PodcastCardProps = {
  podcastId: string;
  name: string;
  description: string;
  releaseDate: string;
  genres: string;
  onClick: () => void;
};

export default function PodcastCard({ podcastId, name, description, releaseDate, genres, onClick }: PodcastCardProps) {
  const genreList = genres.split(",");
  return (
    <Card className="h-50 flex flex-row cursor-pointer hover:scale-102 duration-150 active:scale-98" onClick={onClick}>
      <div className="w-50 flex items-center">
        <CardContent>
          <img src={podcast} className="h-40 object-cover rounded-sm" />
        </CardContent>
      </div>
      <div className="flex-1 flex flex-col justify-between">
        <CardHeader>
          <CardTitle className="font-bold">{name}</CardTitle>
          <CardDescription>{description}</CardDescription>
          <CardDescription className="text-xs">{dateFormat(releaseDate)}</CardDescription>
        </CardHeader>
        <CardFooter className="flex flex-col items-baseline">
          <div className="flex flex-row gap-1">
            {genreList.map((genre) => (
              <Button
                key={genre}
                className="text-xs bg-transparent border text-gray-300 hover:bg-transparent cursor-pointer hover:scale-97 duration-150"
              >
                {genre}
              </Button>
            ))}
          </div>
        </CardFooter>
      </div>
    </Card>
  );
}
