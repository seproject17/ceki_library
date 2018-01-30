class AddBookReferenceToBorrowings < ActiveRecord::Migration[5.1]
  def change
    add_reference :borrowings, :book, foreign_key: true
  end
end
