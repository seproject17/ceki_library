class ChangeRoleInUser < ActiveRecord::Migration[5.1]
  def change
    change_column :users, :role, :integer, :default => 0, :null => false
  end
end
