class BookChildrenDeleteOnCascade < ActiveRecord::Migration[5.1]
  def change
    remove_foreign_key :borrowings, :books
    add_foreign_key :borrowings, :books, on_delete: :cascade

    remove_foreign_key :reviews, :books
    add_foreign_key :reviews, :books, on_delete: :cascade
  end
end
