class Entities::Document

  def self.create_youtube_video(user, video_meta_data)
    document = create_a_document(user)
    if !document.nil?
      return Entities::Media.create_youtube_video(video_meta_data, document)
    end
    nil
  end

  def self.create_a_document(user)
    begin
      Document.create!({account: user.account})
    rescue Exception => exp
      puts exp
      nil
    end
  end
end
