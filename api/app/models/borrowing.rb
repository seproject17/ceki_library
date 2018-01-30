class Borrowing < ApplicationRecord
  enum status: [:borrowed, :returned]
  belongs_to :book
  belongs_to :user
end