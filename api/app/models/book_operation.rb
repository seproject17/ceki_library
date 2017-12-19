class BookOperation < ApplicationRecord
  enum type: [:add, :update, :delete, :borrow, :return], _suffix: true
end
