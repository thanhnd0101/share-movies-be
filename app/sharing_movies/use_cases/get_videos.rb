class UseCases::GetVideos

  def self.get_videos(opt)
    Services::GetPaginatedVideosIfNeeded.call(opt)
  end
end
