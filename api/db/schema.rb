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

ActiveRecord::Schema.define(version: 20180201011713) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "books", force: :cascade do |t|
    t.string "isbn"
    t.string "title"
    t.string "author"
    t.string "publisher"
    t.date "year"
    t.string "annotations"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.bigint "user_id"
    t.integer "available_count", default: 0
    t.integer "max_count", default: 0
    t.string "cover_path"
    t.index ["user_id"], name: "index_books_on_user_id"
  end

  create_table "borrowings", force: :cascade do |t|
    t.date "borrow_date"
    t.date "return_date"
    t.date "actual_date"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.bigint "user_id"
    t.bigint "book_id"
    t.integer "status", default: 0
    t.index ["book_id"], name: "index_borrowings_on_book_id"
    t.index ["user_id"], name: "index_borrowings_on_user_id"
  end

  create_table "reviews", force: :cascade do |t|
    t.string "comments"
    t.integer "mark"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.bigint "user_id"
    t.bigint "book_id"
    t.index ["book_id"], name: "index_reviews_on_book_id"
    t.index ["user_id"], name: "index_reviews_on_user_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "name"
    t.string "surname"
    t.string "email"
    t.string "password_digest"
    t.integer "role", default: 0, null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "avatar_path"
  end

  add_foreign_key "books", "users", on_delete: :cascade
  add_foreign_key "borrowings", "books", on_delete: :cascade
  add_foreign_key "borrowings", "users", on_delete: :cascade
  add_foreign_key "reviews", "books", on_delete: :cascade
  add_foreign_key "reviews", "users", on_delete: :cascade
end
