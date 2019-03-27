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

ActiveRecord::Schema.define(version: 2019_03_27_203801) do

  create_table "url_accesses", force: :cascade do |t|
    t.integer "url_id"
    t.datetime "accessed"
    t.string "ip"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["url_id"], name: "index_url_accesses_on_url_id"
  end

  create_table "urls", force: :cascade do |t|
    t.string "base_url"
    t.string "shortened_url"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["shortened_url"], name: "index_urls_on_shortened_url", unique: true
  end

end
