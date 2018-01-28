class DropBookOperationsTable < ActiveRecord::Migration[5.1]
  def change
    drop_table :book_operations
  end
end
