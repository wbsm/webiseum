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

ActiveRecord::Schema.define(version: 20131014020505) do

  create_table "authentications", force: true do |t|
    t.integer  "user_id"
    t.string   "provider"
    t.string   "uid"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "comments", force: true do |t|
    t.text     "message"
    t.integer  "forecast_id"
    t.integer  "user_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "comments", ["forecast_id"], name: "index_comments_on_forecast_id"
  add_index "comments", ["user_id"], name: "index_comments_on_user_id"

  create_table "forecasts", force: true do |t|
    t.integer  "rating"
    t.text     "comment"
    t.integer  "user_id"
    t.integer  "question_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "answer"
  end

  create_table "questions", force: true do |t|
    t.string   "title"
    t.text     "description"
    t.datetime "publish_at"
    t.datetime "finish_at"
    t.datetime "event_at"
    t.text     "answers"
    t.string   "correct_answer"
    t.binary   "image_type"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.boolean  "rank_update",         default: false, null: false
    t.string   "avatar_file_name"
    t.string   "avatar_content_type"
    t.integer  "avatar_file_size"
    t.datetime "avatar_updated_at"
  end

  create_table "questions_tags", force: true do |t|
    t.integer "question_id"
    t.integer "tag_id"
  end

  create_table "ranks", force: true do |t|
    t.integer  "score",      default: 0
    t.integer  "user_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "ranks", ["user_id"], name: "index_ranks_on_user_id"

  create_table "tag_ranks", force: true do |t|
    t.integer  "score",      default: 0
    t.integer  "user_id"
    t.integer  "tag_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "tag_ranks", ["tag_id"], name: "index_tag_ranks_on_tag_id"
  add_index "tag_ranks", ["user_id"], name: "index_tag_ranks_on_user_id"

  create_table "tags", force: true do |t|
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "users", force: true do |t|
    t.string   "name"
    t.string   "email"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "rank_score",          default: 0,                   null: false
    t.string   "first_name"
    t.string   "last_name"
    t.string   "gender"
    t.binary   "image"
    t.string   "password_digest"
    t.string   "avatar_file_name"
    t.string   "avatar_content_type"
    t.integer  "avatar_file_size"
    t.datetime "avatar_updated_at"
    t.date     "birthday"
    t.string   "time_zone",           default: "America/Sao_Paulo"
  end

  add_index "users", ["email"], name: "index_users_on_email", unique: true

end
