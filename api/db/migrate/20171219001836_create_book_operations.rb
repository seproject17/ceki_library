class CreateBookOperations < ActiveRecord::Migration[5.1]
  def change
    create_table :book_operations do |t|
      t.string :type
      t.date :start_date
      t.date :end_date
      t.string :comments

      t.timestamps
    end
  end
end
