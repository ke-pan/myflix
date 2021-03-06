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
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 20140830014545) do

  create_table "billings", force: true do |t|
    t.datetime "pay_date"
    t.integer  "user_id"
    t.datetime "active_until"
    t.float    "amount"
  end

  add_index "billings", ["user_id"], name: "index_billings_on_user_id"

  create_table "categories", force: true do |t|
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "followships", force: true do |t|
    t.integer  "user_id"
    t.integer  "followee_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "invitations", force: true do |t|
    t.string  "name"
    t.string  "email"
    t.string  "token"
    t.integer "user_id"
    t.text    "message"
  end

  create_table "queue_items", force: true do |t|
    t.integer  "user_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "video_id"
    t.integer  "position"
  end

  create_table "reviews", force: true do |t|
    t.integer  "rate"
    t.integer  "user_id"
    t.integer  "video_id"
    t.string   "description"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "users", force: true do |t|
    t.string   "name"
    t.string   "email"
    t.string   "password_digest"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "reset_password_token"
    t.boolean  "admin"
    t.datetime "active_until"
    t.string   "stripe_user_id"
    t.boolean  "active"
  end

  create_table "video_category_relations", force: true do |t|
    t.integer  "video_id"
    t.integer  "category_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "videos", force: true do |t|
    t.string   "name"
    t.text     "description"
    t.string   "small_cover"
    t.string   "large_cover"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "video_url"
  end

end
