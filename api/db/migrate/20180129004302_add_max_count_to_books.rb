class AddMaxCountToBooks < ActiveRecord::Migration[5.1]
  def change
    add_column :books, :max_count, :integer, :default => 0
  end
end
