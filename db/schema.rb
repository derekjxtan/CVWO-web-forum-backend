# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# This file is the source Rails uses to define your schema when running `bin/rails
# db:schema:load`. When creating a new database, `bin/rails db:schema:load` tends to
# be faster and is potentially less error prone than running all of your
# migrations from scratch. Old migrations may fail to apply correctly if those
# migrations use external dependencies or application code.
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema[7.0].define(version: 2023_01_15_070930) do
  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "disliked_posts", force: :cascade do |t|
    t.bigint "user_id", null: false
    t.bigint "post_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["post_id"], name: "index_disliked_posts_on_post_id"
    t.index ["user_id"], name: "index_disliked_posts_on_user_id"
  end

  create_table "disliked_replies", force: :cascade do |t|
    t.bigint "user_id", null: false
    t.bigint "reply_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["reply_id"], name: "index_disliked_replies_on_reply_id"
    t.index ["user_id"], name: "index_disliked_replies_on_user_id"
  end

  create_table "liked_posts", force: :cascade do |t|
    t.bigint "user_id", null: false
    t.bigint "post_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["post_id"], name: "index_liked_posts_on_post_id"
    t.index ["user_id"], name: "index_liked_posts_on_user_id"
  end

  create_table "liked_replies", force: :cascade do |t|
    t.bigint "user_id", null: false
    t.bigint "reply_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["reply_id"], name: "index_liked_replies_on_reply_id"
    t.index ["user_id"], name: "index_liked_replies_on_user_id"
  end

  create_table "posts", force: :cascade do |t|
    t.string "title"
    t.text "body"
    t.bigint "user_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "categories", default: [], array: true
    t.integer "likes", default: 0
    t.integer "dislikes", default: 0
    t.integer "saves", default: 0
    t.index ["user_id"], name: "index_posts_on_user_id"
  end

  create_table "replies", force: :cascade do |t|
    t.text "body"
    t.bigint "user_id", null: false
    t.bigint "post_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "likes", default: 0
    t.integer "dislikes", default: 0
    t.bigint "reply_id"
    t.integer "replies_count", default: 0
    t.index ["post_id"], name: "index_replies_on_post_id"
    t.index ["reply_id"], name: "index_replies_on_reply_id"
    t.index ["user_id"], name: "index_replies_on_user_id"
  end

  create_table "saved_posts", force: :cascade do |t|
    t.bigint "user_id", null: false
    t.bigint "post_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["post_id"], name: "index_saved_posts_on_post_id"
    t.index ["user_id"], name: "index_saved_posts_on_user_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "username"
    t.string "password_digest"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_foreign_key "disliked_posts", "posts"
  add_foreign_key "disliked_posts", "users"
  add_foreign_key "disliked_replies", "replies"
  add_foreign_key "disliked_replies", "users"
  add_foreign_key "liked_posts", "posts"
  add_foreign_key "liked_posts", "users"
  add_foreign_key "liked_replies", "replies"
  add_foreign_key "liked_replies", "users"
  add_foreign_key "posts", "users"
  add_foreign_key "replies", "posts"
  add_foreign_key "replies", "replies"
  add_foreign_key "replies", "users"
  add_foreign_key "saved_posts", "posts"
  add_foreign_key "saved_posts", "users"
end
