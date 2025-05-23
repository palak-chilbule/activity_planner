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

ActiveRecord::Schema[7.1].define(version: 2025_04_19_092904) do
  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "activities", force: :cascade do |t|
    t.string "title"
    t.text "description"
    t.string "frequency"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "program_day_activities", force: :cascade do |t|
    t.bigint "program_day_id", null: false
    t.bigint "activity_id", null: false
    t.bigint "user_id", null: false
    t.boolean "completed", default: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.datetime "program_start_date"
    t.datetime "program_end_date"
    t.index ["activity_id"], name: "index_program_day_activities_on_activity_id"
    t.index ["program_day_id"], name: "index_program_day_activities_on_program_day_id"
    t.index ["user_id"], name: "index_program_day_activities_on_user_id"
  end

  create_table "program_days", force: :cascade do |t|
    t.integer "day_number"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "users", force: :cascade do |t|
    t.string "name"
    t.string "email"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_foreign_key "program_day_activities", "activities"
  add_foreign_key "program_day_activities", "program_days"
  add_foreign_key "program_day_activities", "users"
end
