class Book < ApplicationRecord
  # mount_uploader :cover, BookCoverUploader
  # mount_uploader :file, BookFileUploader

  def available?
    self.available_count > 0
  end
end
