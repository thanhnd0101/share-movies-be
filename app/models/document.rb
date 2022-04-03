class Document < ApplicationRecord
  belongs_to :account
  has_many :upload_media

  scope :id_list, -> (ids) {where(id:  ids)}
end
