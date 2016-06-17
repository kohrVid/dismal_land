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

ActiveRecord::Schema.define(version: 5) do

  create_table "comments", force: :cascade do |t|
    t.string   "author"
    t.text     "body"
    t.integer  "location_id"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
  end

  add_index "comments", ["location_id"], name: "index_comments_on_location_id"

  create_table "directions", force: :cascade do |t|
    t.integer  "location_id"
    t.integer  "destination_id"
    t.string   "direction"
    t.datetime "created_at",     null: false
    t.datetime "updated_at",     null: false
  end

  add_index "directions", ["destination_id"], name: "index_directions_on_destination_id"
  add_index "directions", ["location_id"], name: "index_directions_on_location_id"

  create_table "location_tags", force: :cascade do |t|
    t.integer  "location_id"
    t.integer  "tag_id"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
  end

  add_index "location_tags", ["location_id"], name: "index_location_tags_on_location_id"
  add_index "location_tags", ["tag_id"], name: "index_location_tags_on_tag_id"

  create_table "locations", force: :cascade do |t|
    t.string   "name"
    t.text     "description"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
  end

  create_table "tags", force: :cascade do |t|
    t.string   "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

end
