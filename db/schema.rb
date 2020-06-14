# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# This file is the source Rails uses to define your schema when running `rails
# db:schema:load`. When creating a new database, `rails db:schema:load` tends to
# be faster and is potentially less error prone than running all of your
# migrations from scratch. Old migrations may fail to apply correctly if those
# migrations use external dependencies or application code.
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 2020_06_14_075454) do

  create_table "rooms", force: :cascade do |t|
    t.string "title", null: false
    t.string "description"
    t.date "complete_at", null: false
    t.string "category"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.string "invite_code", null: false
    t.index ["invite_code"], name: "index_rooms_on_invite_code", unique: true
  end

  create_table "rooms_users", id: false, force: :cascade do |t|
    t.integer "room_id", null: false
    t.integer "user_id", null: false
  end

  create_table "users", force: :cascade do |t|
    t.string "username", null: false
    t.string "nickname", null: false
    t.string "profile_pic"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.string "password_digest"
    t.index ["username"], name: "index_users_on_username", unique: true
  end

  create_table "videos", force: :cascade do |t|
    t.integer "clicks"
    t.string "file_path"
    t.integer "length"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.integer "room_id", null: false
    t.integer "user_id", null: false
    t.index ["room_id"], name: "index_videos_on_room_id"
    t.index ["user_id"], name: "index_videos_on_user_id"
  end

  add_foreign_key "videos", "rooms"
  add_foreign_key "videos", "users"
end
