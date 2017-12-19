class CreateBookItems < ActiveRecord::Migration[5.1]
  def change
    create_table :book_items do |t|
      t.string :file
      t.integer :pages
      t.string :location
      t.string :type

      t.timestamps
    end
  end
end
