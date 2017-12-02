class CreateEBooks < ActiveRecord::Migration[5.1]
  def change
    create_table :e_books do |t|
      t.string :title
      t.string :author
      t.string :publisher
      t.date :year
      t.string :annotations
      t.string :file_path

      t.timestamps
    end
  end
end
