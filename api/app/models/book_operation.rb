class BookOperation < ApplicationRecord
  enum operation: [:create, :borrow, :return, :update, :destroy], _suffix: true
end
