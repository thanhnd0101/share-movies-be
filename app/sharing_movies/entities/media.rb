class Entities::Media
  def self.create_youtube_video(document, video_metadata, url)
    upload_media = UploadMedia.new
    upload_media.document = document
    upload_media.url = url
    upload_media.meta_data = video_metadata
    upload_media.youtube_video!

    upload_media.save!
  end

end
