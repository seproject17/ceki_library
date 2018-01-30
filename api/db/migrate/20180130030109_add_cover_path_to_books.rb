class AddCoverPathToBooks < ActiveRecord::Migration[5.1]
  def change
    add_column :uploads, :cover_path, :string
  end
end
