class UserChildrenDeleteOnCascade < ActiveRecord::Migration[5.1]
  def change
    remove_foreign_key :books, :users
    add_foreign_key :books, :users, on_delete: :cascade

    remove_foreign_key :borrowings, :users
    add_foreign_key :borrowings, :users, on_delete: :cascade

    remove_foreign_key :reviews, :users
    add_foreign_key :reviews, :users, on_delete: :cascade
  end
end
