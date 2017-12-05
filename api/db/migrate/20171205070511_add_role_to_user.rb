class AddRoleToUser < ActiveRecord::Migration[5.1]
  def change
    add_column :users, :role, :integer, default: 2
  end
end
