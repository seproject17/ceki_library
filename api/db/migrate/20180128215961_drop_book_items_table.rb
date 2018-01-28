class DropBookItemsTable < ActiveRecord::Migration[5.1]
  def change
    drop_table :book_items
  end
end
