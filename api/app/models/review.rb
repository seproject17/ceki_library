class Review < ApplicationRecord
  belongs_to :user, optional: false
  belongs_to :book, optional: false

  # def as_json(options = {})
  #   @user = self.user.as_json
  #   @book = self.book.as_json
  #   super((options || {})).merge({'user': @user, 'book': @book})
  # end
end
