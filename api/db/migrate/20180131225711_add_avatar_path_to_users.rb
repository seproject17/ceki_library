class AddAvatarPathToUsers < ActiveRecord::Migration[5.1]
  def change
    add_column :users, :avatar_path, :string
  end
end
