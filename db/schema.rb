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

ActiveRecord::Schema[7.0].define(version: 2024_02_14_161441) do
  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "addresses", force: :cascade do |t|
    t.string "address"
    t.string "latitude"
    t.string "longitude"
    t.bigint "customer_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["customer_id"], name: "index_addresses_on_customer_id"
  end

  create_table "admins", force: :cascade do |t|
    t.bigint "person_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["person_id"], name: "index_admins_on_person_id"
  end

  create_table "brands", force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "clothing_inventories", force: :cascade do |t|
    t.integer "quantity"
    t.bigint "clothing_type_id", null: false
    t.bigint "order_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["clothing_type_id"], name: "index_clothing_inventories_on_clothing_type_id"
    t.index ["order_id"], name: "index_clothing_inventories_on_order_id"
  end

  create_table "clothing_types", force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "customers", force: :cascade do |t|
    t.string "code"
    t.bigint "person_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["person_id"], name: "index_customers_on_person_id"
  end

  create_table "drivers", force: :cascade do |t|
    t.string "driver_license"
    t.string "identity_card"
    t.bigint "motorcycle_id", null: false
    t.bigint "person_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["motorcycle_id"], name: "index_drivers_on_motorcycle_id"
    t.index ["person_id"], name: "index_drivers_on_person_id"
  end

  create_table "models", force: :cascade do |t|
    t.string "name"
    t.string "year"
    t.bigint "brand_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["brand_id"], name: "index_models_on_brand_id"
  end

  create_table "motorcycles", force: :cascade do |t|
    t.boolean "status"
    t.string "license_plate"
    t.bigint "model_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["model_id"], name: "index_motorcycles_on_model_id"
  end

  create_table "order_statuses", force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "orders", force: :cascade do |t|
    t.bigint "pickup_address_id", null: false
    t.bigint "delivery_address_id", null: false
    t.datetime "scheduled_date_time"
    t.datetime "pickup_date_time"
    t.datetime "delivery_date_time"
    t.decimal "total_amount"
    t.string "notes"
    t.bigint "driver_id", null: false
    t.bigint "order_status_id", null: false
    t.bigint "payment_status_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["delivery_address_id"], name: "index_orders_on_delivery_address_id"
    t.index ["driver_id"], name: "index_orders_on_driver_id"
    t.index ["order_status_id"], name: "index_orders_on_order_status_id"
    t.index ["payment_status_id"], name: "index_orders_on_payment_status_id"
    t.index ["pickup_address_id"], name: "index_orders_on_pickup_address_id"
  end

  create_table "payment_statuses", force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "payments", force: :cascade do |t|
    t.decimal "amount"
    t.datetime "date"
    t.bigint "order_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["order_id"], name: "index_payments_on_order_id"
  end

  create_table "people", force: :cascade do |t|
    t.string "first_name"
    t.string "last_name"
    t.string "phone"
    t.string "email"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "users", force: :cascade do |t|
    t.string "provider", default: "email", null: false
    t.string "uid", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.boolean "allow_password_change", default: false
    t.datetime "remember_created_at"
    t.string "confirmation_token"
    t.datetime "confirmed_at"
    t.datetime "confirmation_sent_at"
    t.string "unconfirmed_email"
    t.string "name"
    t.string "nickname"
    t.string "image"
    t.string "email"
    t.json "tokens"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.bigint "person_id", null: false
    t.index ["confirmation_token"], name: "index_users_on_confirmation_token", unique: true
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["person_id"], name: "index_users_on_person_id"
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
    t.index ["uid", "provider"], name: "index_users_on_uid_and_provider", unique: true
  end

  add_foreign_key "addresses", "customers"
  add_foreign_key "admins", "people"
  add_foreign_key "clothing_inventories", "clothing_types"
  add_foreign_key "clothing_inventories", "orders"
  add_foreign_key "customers", "people"
  add_foreign_key "drivers", "motorcycles"
  add_foreign_key "drivers", "people"
  add_foreign_key "models", "brands"
  add_foreign_key "motorcycles", "models"
  add_foreign_key "orders", "addresses", column: "delivery_address_id"
  add_foreign_key "orders", "addresses", column: "pickup_address_id"
  add_foreign_key "orders", "drivers"
  add_foreign_key "orders", "order_statuses"
  add_foreign_key "orders", "payment_statuses"
  add_foreign_key "payments", "orders"
  add_foreign_key "users", "people"
end
