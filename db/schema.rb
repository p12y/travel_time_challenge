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

ActiveRecord::Schema.define(version: 20170720155839) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "journeys", force: :cascade do |t|
    t.time "start_time"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "name"
  end

  create_table "meetings", force: :cascade do |t|
    t.string "postcode"
    t.time "duration"
    t.string "name"
    t.bigint "journey_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["journey_id"], name: "index_meetings_on_journey_id"
  end

  add_foreign_key "meetings", "journeys"
end
