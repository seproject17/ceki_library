class CreateBookOperations < ActiveRecord::Migration[5.1]
  def change
    create_table :book_operations do |t|
      t.date :op_date
      t.integer :operation, default: 0
      t.timestamps
    end
  end
end
