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

ActiveRecord::Schema.define(version: 2021_12_10_124213) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "pgcrypto"
  enable_extension "plpgsql"

  create_table "claims", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.string "email"
    t.string "first_name"
    t.string "last_name"
    t.integer "state"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "flights", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.string "flight_identifier"
    t.string "airline_code"
    t.string "flight_number"
    t.string "departure_date"
    t.string "departure_airport_code"
    t.string "arrival_airport_code"
    t.integer "delay_mins"
    t.integer "flight_status"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["flight_identifier"], name: "index_flights_on_flight_identifier", unique: true
  end

  create_table "iterinaries", force: :cascade do |t|
    t.uuid "claim_id", null: false
    t.uuid "flight_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["claim_id"], name: "index_iterinaries_on_claim_id"
    t.index ["flight_id"], name: "index_iterinaries_on_flight_id"
  end

  add_foreign_key "iterinaries", "claims"
  add_foreign_key "iterinaries", "flights"
end
