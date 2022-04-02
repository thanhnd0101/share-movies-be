class Entities::Media
  def self.create_youtube_video(video_meta_data, document)
    upload_media = UploadMedia.new
    upload_media.document = document
    upload_media.meta_data = video_meta_data
    upload_media.youtube_video!

    upload_media.save!
  end

end
