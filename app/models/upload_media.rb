class UploadMedia < ApplicationRecord
  enum media_type: [:youtube_video]

  belongs_to :document

end
