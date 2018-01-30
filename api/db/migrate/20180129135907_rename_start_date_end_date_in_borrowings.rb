class RenameStartDateEndDateInBorrowings < ActiveRecord::Migration[5.1]
  def change
    rename_column :borrowings, :start_date, :borrow_date
    rename_column :borrowings, :end_date, :return_date
  end
end
