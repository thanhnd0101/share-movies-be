class UseCases::ShareYoutubeVideo

  def self.share_a_video(user, youtube_url)
    video_info = GetYoutubeVideoInfo.call(youtube_url)

    Entities::Document.create_youtube_video(user, video_info, youtube_url);
  end
end
