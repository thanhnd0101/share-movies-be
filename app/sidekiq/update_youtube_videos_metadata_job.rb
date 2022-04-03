class UpdateYoutubeVideosMetadataJob
  include Sidekiq::Job

  UPDATE_PERIOD_THRESHOLD_IN_HOURS = ENV["VIDEO_UPDATE_PERIOD_THRESHOLD_IN_HOURS"] || 24

  def perform(document_ids)
    if document_ids.kind_of?(Array) && !document_ids.empty?
      documents = Document.id_list(document_ids).includes(:upload_media)
      documents.each do |document|
        youtube_video = document.upload_media.first
        if (Time.now - youtube_video.updated_at) / 86400 > UPDATE_PERIOD_THRESHOLD_IN_HOURS
          video_metadata = GetYoutubeVideoInfo.call(youtube_video.url)

          youtube_video.update({
                                 meta_data: video_metadata
                               })
          puts 'aaaaaa'
        end
      end
    end
  end
end
