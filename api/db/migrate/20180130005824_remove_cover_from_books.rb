class RemoveCoverFromBooks < ActiveRecord::Migration[5.1]
  def change
    remove_column :books, :cover_path
  end
end
