class CreateBooksTags < ActiveRecord::Migration[5.1]
  def change
    create_join_table :books, :tags do |t|
      t.index :book_id
      t.index :tag_id
    end
  end
end
