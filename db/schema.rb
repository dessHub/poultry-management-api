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

ActiveRecord::Schema[7.0].define(version: 2023_11_29_124619) do
  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "farm_users", force: :cascade do |t|
    t.bigint "farm_id"
    t.bigint "user_id"
    t.string "role", comment: "admin, manager"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["farm_id"], name: "index_farm_users_on_farm_id"
    t.index ["user_id"], name: "index_farm_users_on_user_id"
  end

  create_table "farms", force: :cascade do |t|
    t.string "name"
    t.string "description"
    t.string "country"
    t.string "location"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "users", force: :cascade do |t|
    t.string "name"
    t.string "phone"
    t.string "email"
    t.string "password_digest"
    t.string "password_confirmation"
    t.string "role", comment: "super_admin, farm_user"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_foreign_key "farm_users", "farms"
  add_foreign_key "farm_users", "users"
end
