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

ActiveRecord::Schema[7.0].define(version: 2023_12_04_215819) do
  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "chicken_types", force: :cascade do |t|
    t.string "title"
    t.text "description"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "farm_users", force: :cascade do |t|
    t.bigint "farm_id"
    t.bigint "user_id"
    t.string "role", comment: "admin, manager"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["farm_id"], name: "index_farm_users_on_farm_id"
    t.index ["user_id"], name: "index_farm_users_on_user_id"
  end

  create_table "farming_methods", force: :cascade do |t|
    t.string "title"
    t.text "description"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "farms", force: :cascade do |t|
    t.string "name"
    t.string "description"
    t.string "country"
    t.string "location"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "flocks", force: :cascade do |t|
    t.string "title"
    t.datetime "date_of_birth"
    t.string "breed"
    t.integer "quantity"
    t.text "notes"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.bigint "farming_method_id"
    t.bigint "chicken_type_id"
    t.index ["chicken_type_id"], name: "index_flocks_on_chicken_type_id"
    t.index ["farming_method_id"], name: "index_flocks_on_farming_method_id"
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
  add_foreign_key "flocks", "chicken_types"
  add_foreign_key "flocks", "farming_methods"
end
