class Borrowing < ApplicationRecord
  enum status: [:borrowed, :returned]
end