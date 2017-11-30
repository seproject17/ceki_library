class AddUserToElectronicBook < ActiveRecord::Migration[5.1]
  def change
    add_reference :electronic_books, :user, foreign_key: true
  end
end
