# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# Note that this schema.rb definition is the authoritative source for your
# database schema. If you need to create the application database on another
# system, you should be using db:schema:load, not running all the migrations
# from scratch. The latter is a flawed and unsustainable approach (the more migrations
# you'll amass, the slower it'll run and the greater likelihood for issues).
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 20171204220451) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "book_items", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.bigint "book_id"
    t.index ["book_id"], name: "index_book_items_on_book_id"
  end

  create_table "book_operations", force: :cascade do |t|
    t.date "op_date"
    t.integer "operation", default: 0
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.bigint "user_id"
    t.bigint "book_item_id"
    t.index ["book_item_id"], name: "index_book_operations_on_book_item_id"
    t.index ["user_id"], name: "index_book_operations_on_user_id"
  end

  create_table "books", force: :cascade do |t|
    t.string "title"
    t.string "author"
    t.string "publisher"
    t.date "year"
    t.string "annotations"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "e_books", force: :cascade do |t|
    t.string "title"
    t.string "author"
    t.string "publisher"
    t.date "year"
    t.string "annotations"
    t.string "file_path"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "reviews", force: :cascade do |t|
    t.string "text"
    t.integer "mark"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.bigint "user_id"
    t.index ["user_id"], name: "index_reviews_on_user_id"
  end

  create_table "roles", force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "users", force: :cascade do |t|
    t.string "name"
    t.string "surname"
    t.string "email"
    t.string "password"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "token"
    t.string "password_digest"
    t.index ["token"], name: "index_users_on_token"
  end

  add_foreign_key "book_items", "books"
  add_foreign_key "book_operations", "book_items"
  add_foreign_key "book_operations", "users"
  add_foreign_key "reviews", "users"
end
