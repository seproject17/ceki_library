class RemoveAvatarPathFromUser < ActiveRecord::Migration[5.1]
  def change
    remove_column :users, :avatar_path
  end
end