class User < ApplicationRecord
  has_many :books
  has_many :borrowings
  has_many :reviews
  # mount_uploader :avatar, AvatarUploader
  has_secure_password
  enum role: [:admin, :librarian, :visitor]
end
