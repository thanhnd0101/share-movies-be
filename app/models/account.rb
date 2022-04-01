class Account < ApplicationRecord
  has_secure_password

  has_many :documents

  validates :username, presence: true, uniqueness: true

end
