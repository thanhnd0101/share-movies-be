class Document < ApplicationRecord
  belongs_to :account
  has_many :upload_media
end
