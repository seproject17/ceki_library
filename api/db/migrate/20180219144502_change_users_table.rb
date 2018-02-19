class ChangeUsersTable < ActiveRecord::Migration[5.1]
  def change
    change_column :users, :name, :string, null: false
    change_column :users, :surname, :string, null: false
    change_column :users, :email, :string, null: false, unique: true
    change_column :users, :password_digest, :string, null: false
  end
end
