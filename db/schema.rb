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

ActiveRecord::Schema[7.0].define(version: 2024_06_19_000241) do
  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "business_units", force: :cascade do |t|
    t.string "name", null: false
    t.bigint "user_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "plan_id", null: false
    t.timestamptz "payment_due_date"
    t.timestamptz "notification_date"
    t.timestamptz "trial_end_date"
    t.string "cnpj"
    t.string "state_registration"
    t.string "municipal_registration"
    t.string "legal_name"
    t.string "trade_name"
    t.index ["cnpj", "user_id"], name: "index_business_units_on_cnpj_and_user_id", unique: true
    t.index ["user_id"], name: "index_business_units_on_user_id"
  end

  create_table "clients", force: :cascade do |t|
    t.string "name", null: false
    t.string "email", null: false
    t.bigint "business_unit_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["business_unit_id"], name: "index_clients_on_business_unit_id"
    t.index ["email"], name: "index_clients_on_email"
  end

  create_table "inventory_categories", force: :cascade do |t|
    t.string "name"
    t.bigint "business_unit_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["business_unit_id"], name: "index_inventory_categories_on_business_unit_id"
  end

  create_table "inventory_items", force: :cascade do |t|
    t.string "name", null: false
    t.integer "quantity", null: false
    t.decimal "price", precision: 10, scale: 2, null: false
    t.string "item_type", null: false
    t.bigint "business_unit_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.bigint "inventory_category_id", null: false
    t.index ["business_unit_id"], name: "index_inventory_items_on_business_unit_id"
    t.index ["inventory_category_id"], name: "index_inventory_items_on_inventory_category_id"
    t.index ["item_type"], name: "index_inventory_items_on_item_type"
    t.index ["name"], name: "index_inventory_items_on_name"
  end

  create_table "plans", force: :cascade do |t|
    t.string "name", null: false
    t.decimal "price", precision: 10, scale: 2, null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.decimal "discount", precision: 5, scale: 2, default: "0.0"
    t.string "periodicity", default: "monthly"
    t.string "duration", default: "monthly", null: false
    t.integer "max_business_units", default: 1
  end

  create_table "transactions", force: :cascade do |t|
    t.decimal "amount", precision: 10, scale: 2, null: false
    t.string "description", null: false
    t.string "transaction_type", null: false
    t.string "payment_type", null: false
    t.bigint "business_unit_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.bigint "client_id"
    t.string "status"
    t.string "transaction_scope"
    t.index ["business_unit_id"], name: "index_transactions_on_business_unit_id"
    t.index ["client_id"], name: "index_transactions_on_client_id"
    t.index ["payment_type"], name: "index_transactions_on_payment_type"
    t.index ["transaction_type"], name: "index_transactions_on_transaction_type"
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
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
    t.index ["uid", "provider"], name: "index_users_on_uid_and_provider", unique: true
  end

  add_foreign_key "business_units", "plans"
  add_foreign_key "business_units", "users"
  add_foreign_key "clients", "business_units"
  add_foreign_key "inventory_categories", "business_units"
  add_foreign_key "inventory_items", "business_units"
  add_foreign_key "inventory_items", "inventory_categories"
  add_foreign_key "transactions", "business_units"
  add_foreign_key "transactions", "clients"
end
