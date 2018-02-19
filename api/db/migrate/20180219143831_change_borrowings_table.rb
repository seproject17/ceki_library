class ChangeBorrowingsTable < ActiveRecord::Migration[5.1]
  def change
    change_column :borrowings, :status, :integer, null: false, default: 0
    remove_column :borrowings, :actual_date
  end
end
