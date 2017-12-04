class CreateBookItems < ActiveRecord::Migration[5.1]
  def change
    create_table :book_items do |t|
      t.timestamps
    end
  end
end
