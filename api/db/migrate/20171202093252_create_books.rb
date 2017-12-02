class CreateBooks < ActiveRecord::Migration[5.1]
  def change
    create_table :books do |t|
      t.string :title
      t.string :author
      t.string :publisher
      t.date :year
      t.string :annotations

      t.timestamps
    end
  end
end
