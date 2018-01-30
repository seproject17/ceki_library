class Book < ApplicationRecord
  before_create :set_default_available_count
  # mount_uploader :cover, BookCoverUploader
  # mount_uploader :file, BookFileUploader
  has_many :borrowings
  has_many :reviews

  def available?
    self.available_count > 0
  end

  def set_default_available_count
    self.available_count = self.max_count
  end
end
