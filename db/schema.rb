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

ActiveRecord::Schema.define(version: 20160410021940) do

  create_table "articles", force: :cascade do |t|
    t.string   "title"
    t.datetime "date"
    t.text     "text"
    t.boolean  "current"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "slug"
    t.string   "image_file_name"
    t.string   "image_content_type"
    t.integer  "image_file_size"
    t.datetime "image_updated_at"
  end

  create_table "members", force: :cascade do |t|
    t.string   "name"
    t.text     "bio"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "avatar_file_name"
    t.string   "avatar_content_type"
    t.integer  "avatar_file_size"
    t.datetime "avatar_updated_at"
    t.integer  "gen"
    t.string   "major"
    t.boolean  "current"
    t.string   "slug"
    t.string   "email"
    t.string   "phone"
    t.index ["slug"], name: "index_members_on_slug", unique: true
  end

  create_table "performance_videos", force: :cascade do |t|
    t.string   "title"
    t.string   "link"
    t.integer  "performance_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.index ["performance_id"], name: "index_performance_videos_on_performance_id"
  end

  create_table "performances", force: :cascade do |t|
    t.datetime "date"
    t.string   "title"
    t.string   "location"
    t.text     "description"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "banner_file_name"
    t.string   "banner_content_type"
    t.integer  "banner_file_size"
    t.datetime "banner_updated_at"
    t.string   "slug"
    t.string   "link"
    t.string   "images_link"
    t.index ["slug"], name: "index_performances_on_slug", unique: true
  end

  create_table "users", force: :cascade do |t|
    t.string   "email",                  default: "", null: false
    t.string   "encrypted_password",     default: "", null: false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          default: 0,  null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "username"
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
    t.index ["username"], name: "index_users_on_username", unique: true
  end

  create_table "videos", force: :cascade do |t|
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "link"
    t.string   "title"
    t.string   "slug"
    t.integer  "year"
  end

end
