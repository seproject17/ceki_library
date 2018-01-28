class AddFilePathToBooks < ActiveRecord::Migration[5.1]
  def change
    add_column :books, :file_path, :string
  end
end
