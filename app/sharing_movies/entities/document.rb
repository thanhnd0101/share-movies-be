class Entities::Document

  def self.create_youtube_video(user, video_meta_data)
    document = create_a_document(user)

    Entities::Media.create_youtube_video(video_meta_data, document)
  end

  def self.create_a_document(user)
    Document.create!({account: user.account})
  end
end
