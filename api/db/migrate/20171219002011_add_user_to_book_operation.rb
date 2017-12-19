class AddUserToBookOperation < ActiveRecord::Migration[5.1]
  def change
    add_reference :book_operations, :user, foreign_key: true
  end
end
