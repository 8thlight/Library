# encoding: UTF-8
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
# It's strongly recommended to check this file into your version control system.

ActiveRecord::Schema.define(:version => 20130227192437) do

  create_table "books", :force => true do |t|
    t.string   "title"
    t.string   "author"
    t.string   "isbn"
    t.integer  "quantity"
    t.datetime "created_at",    :null => false
    t.datetime "updated_at",    :null => false
    t.integer  "quantity_left"
  end

  create_table "books_users", :id => false, :force => true do |t|
    t.integer "book_id"
    t.integer "user_id"
  end

  add_index "books_users", ["book_id", "user_id"], :name => "index_books_users_on_book_id_and_user_id"
  add_index "books_users", ["user_id", "book_id"], :name => "index_books_users_on_user_id_and_book_id"

  create_table "checkouts", :force => true do |t|
    t.integer  "book_id"
    t.integer  "user_id"
    t.datetime "check_out_date"
    t.datetime "created_at",     :null => false
    t.datetime "updated_at",     :null => false
  end

  create_table "users", :force => true do |t|
    t.string   "name"
    t.string   "email"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
    t.string   "provider"
    t.string   "uid"
  end

end
