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

ActiveRecord::Schema.define(version: 20170405103631) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "chatrooms", force: :cascade do |t|
    t.string   "topic",                                  null: false
    t.datetime "created_at",                             null: false
    t.datetime "updated_at",                             null: false
    t.integer  "user_id"
    t.integer  "posts_id"
    t.string   "slug"
    t.string   "description", default: "No description"
    t.string   "creator",                                null: false
    t.index ["posts_id"], name: "index_chatrooms_on_posts_id", using: :btree
    t.index ["slug"], name: "index_chatrooms_on_slug", unique: true, using: :btree
    t.index ["topic"], name: "index_chatrooms_on_topic", unique: true, using: :btree
    t.index ["user_id"], name: "index_chatrooms_on_user_id", using: :btree
  end

  create_table "members", force: :cascade do |t|
    t.integer  "chatroom_id"
    t.integer  "user_id"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
    t.index ["chatroom_id"], name: "index_members_on_chatroom_id", using: :btree
    t.index ["user_id", "chatroom_id"], name: "index_members_on_user_id_and_chatroom_id", unique: true, using: :btree
    t.index ["user_id"], name: "index_members_on_user_id", using: :btree
  end

  create_table "posts", force: :cascade do |t|
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
    t.integer  "chatroom_id"
    t.integer  "user_id"
    t.string   "content"
    t.index ["chatroom_id"], name: "index_posts_on_chatroom_id", using: :btree
    t.index ["user_id"], name: "index_posts_on_user_id", using: :btree
  end

  create_table "users", force: :cascade do |t|
    t.string   "email",                  default: "",    null: false
    t.string   "encrypted_password",     default: "",    null: false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          default: 0,     null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.inet     "current_sign_in_ip"
    t.inet     "last_sign_in_ip"
    t.datetime "created_at",                             null: false
    t.datetime "updated_at",                             null: false
    t.string   "username"
    t.boolean  "admin",                  default: false
    t.integer  "chatroom_id"
    t.integer  "posts_id"
    t.index ["chatroom_id"], name: "index_users_on_chatroom_id", using: :btree
    t.index ["email"], name: "index_users_on_email", unique: true, using: :btree
    t.index ["posts_id"], name: "index_users_on_posts_id", using: :btree
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true, using: :btree
    t.index ["username"], name: "index_users_on_username", unique: true, using: :btree
  end

  add_foreign_key "chatrooms", "posts", column: "posts_id"
  add_foreign_key "chatrooms", "users"
  add_foreign_key "posts", "chatrooms"
  add_foreign_key "posts", "users"
  add_foreign_key "users", "chatrooms"
  add_foreign_key "users", "posts", column: "posts_id"
end
