class Borrowing < ApplicationRecord
  enum status: [:ordered, :accepted, :rejected, :borrowed, :returned]
  belongs_to :book
  belongs_to :user

  def as_json(options = {})
    @user = self.user.as_json
    @book = self.book.as_json
    super((options || {})).merge({'user': @user, 'book': @book})
  end

end