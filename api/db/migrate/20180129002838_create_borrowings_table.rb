class CreateBorrowingsTable < ActiveRecord::Migration[5.1]
  def change
    create_table :borrowings do |t|
      t.date :start_date
      t.date :end_date
      t.date :actual_date

      t.timestamps
    end
  end
end
