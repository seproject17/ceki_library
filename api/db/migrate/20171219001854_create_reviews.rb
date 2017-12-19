class CreateReviews < ActiveRecord::Migration[5.1]
  def change
    create_table :reviews do |t|
      t.string :comments
      t.integer :mark

      t.timestamps
    end
  end
end
