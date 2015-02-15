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

ActiveRecord::Schema.define(version: 20150214173446) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "alternate_names", force: true do |t|
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "event_places", force: true do |t|
    t.integer  "place_id"
    t.integer  "event_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "events", force: true do |t|
    t.integer  "number_infected"
    t.datetime "date"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "medical_condition_id"
    t.integer  "outbreak_id"
    t.integer  "geo_id"
  end

  create_table "geo_places", force: true do |t|
    t.integer  "place_id"
    t.integer  "geo_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "geos", force: true do |t|
    t.float    "latitude"
    t.float    "longitude"
    t.string   "name"
    t.string   "gazateer"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "county"
    t.integer  "place_id"
  end

  create_table "medical_cause_conditions", force: true do |t|
    t.integer  "medical_cause_id"
    t.integer  "medical_condition_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "medical_causes", force: true do |t|
    t.string   "name"
    t.text     "description"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "medical_code_conditions", id: false, force: true do |t|
    t.integer  "medical_code_id"
    t.integer  "medical_condition_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "medical_code_therapies", force: true do |t|
    t.integer  "medical_therapy_id"
    t.integer  "medical_code_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "medical_codes", force: true do |t|
    t.string   "code_system"
    t.string   "code_value"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "medical_condition_outbreaks", force: true do |t|
    t.integer  "medical_condition_id"
    t.integer  "outbreak_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "medical_conditions", force: true do |t|
    t.string   "name"
    t.text     "description"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "medical_therapies", force: true do |t|
    t.string   "name"
    t.text     "description"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "outbreak_places", force: true do |t|
    t.integer  "outbreak_id"
    t.integer  "place_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "outbreaks", force: true do |t|
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "title"
    t.text     "description"
  end

  create_table "places", force: true do |t|
    t.string   "name"
    t.string   "abbreviation"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "primary_preventions", force: true do |t|
    t.integer "medical_condition_id"
    t.integer "medical_therapy_id"
  end

  create_table "synonyms", force: true do |t|
    t.integer  "medical_condition_id"
    t.integer  "alternate_name_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "therapy_alternate_names", force: true do |t|
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "therapy_synonyms", force: true do |t|
    t.integer  "therapy_alternate_name_id"
    t.integer  "medical_therapy_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "users", force: true do |t|
    t.string   "name"
    t.string   "password_digest"
    t.string   "email"
    t.string   "tier",            default: "unconfirmed"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

end
