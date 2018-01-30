class AddStatusToBorrowings < ActiveRecord::Migration[5.1]
  def change
    add_column :borrowings, :status, :integer, default: 0
  end
end
