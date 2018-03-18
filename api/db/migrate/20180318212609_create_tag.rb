class CreateTag < ActiveRecord::Migration[5.1]
  def change
    create_table :tags do |t|
      t.string :name, unique: true, null: false
    end
  end
end
