class AddAvailableCountToBooks < ActiveRecord::Migration[5.1]
  def change
    add_column :books, :available_count, :integer, :default => 0
  end
end
