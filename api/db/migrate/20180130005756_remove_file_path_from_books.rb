class RemoveFilePathFromBooks < ActiveRecord::Migration[5.1]
  def change
    remove_column :books, :file_path
  end
end
