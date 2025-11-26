type BaseReviewProps = {
  username: string;
  podcast_name: string;
  rating: string;
  comment: string;
  created_at: string;
  //onClick: () => void;
};

type PodcastReviewProps = BaseReviewProps & {
  type: "podcast";
};

type EpisodeReviewProps = BaseReviewProps & {
  type: "episode";
  episode_num: string;
};

type ReviewCardProps = {
  review: PodcastReviewProps | EpisodeReviewProps;
};

export default function ReviewCard({ review }: ReviewCardProps) {
  return (
    <>
      <div className="bg-green-300 cursor-pointer">
        {review.podcast_name}
        {review.type === "episode" && review.episode_num}
        Rating: {review.rating}
      </div>
      <div>
        {review.username}
        <li>{review.comment}</li>
        <li>{review.created_at}</li>
      </div>
    </>
  );
}
