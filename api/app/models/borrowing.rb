class Borrowing < ApplicationRecord
  enum status: [:ordered, :accepted, :rejected, :borrowed, :returned]
  belongs_to :book
  belongs_to :user
end