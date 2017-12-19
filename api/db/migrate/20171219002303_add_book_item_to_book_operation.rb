class AddBookItemToBookOperation < ActiveRecord::Migration[5.1]
  def change
    add_reference :book_operations, :book_item, foreign_key: true
  end
end
