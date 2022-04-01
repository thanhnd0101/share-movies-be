class UploadMedia < ApplicationRecord
  enum media_type: [:video, :image]

  belongs_to :document

end
