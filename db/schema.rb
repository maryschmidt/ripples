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

ActiveRecord::Schema.define(version: 20150817193401) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "matches", force: :cascade do |t|
    t.string  "region"
    t.string  "match_version"
    t.string  "queue_type"
    t.integer "match_duration", limit: 8
    t.integer "match_id",       limit: 8
  end

  create_table "participants", force: :cascade do |t|
    t.integer "champion_id"
    t.integer "team_id"
    t.integer "participant_id"
    t.integer "items",                                 array: true
    t.integer "gold_earned"
    t.integer "gold_spent"
    t.string  "role"
    t.integer "kills"
    t.integer "deaths"
    t.integer "assists"
    t.boolean "win",                      null: false
    t.text    "timeline"
    t.integer "match_id",       limit: 8
  end

end
