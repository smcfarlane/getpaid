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

ActiveRecord::Schema.define(version: 20150717203733) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"
  enable_extension "hstore"

  create_table "accounts", force: :cascade do |t|
    t.string   "email",                  default: "", null: false
    t.string   "encrypted_password",     default: "", null: false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          default: 0,  null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.inet     "current_sign_in_ip"
    t.inet     "last_sign_in_ip"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "provider",                            null: false
    t.string   "uid",                    default: "", null: false
    t.string   "confirmation_token"
    t.datetime "confirmed_at"
    t.datetime "confirmation_sent_at"
    t.string   "name"
    t.text     "tokens"
    t.string   "unconfirmed_email"
  end

  add_index "accounts", ["confirmation_token"], name: "index_accounts_on_confirmation_token", unique: true, using: :btree
  add_index "accounts", ["email"], name: "index_accounts_on_email", unique: true, using: :btree
  add_index "accounts", ["reset_password_token"], name: "index_accounts_on_reset_password_token", unique: true, using: :btree
  add_index "accounts", ["uid", "provider"], name: "index_accounts_on_uid_and_provider", unique: true, using: :btree

  create_table "accounts_roles", id: false, force: :cascade do |t|
    t.integer "account_id"
    t.integer "role_id"
  end

  add_index "accounts_roles", ["account_id", "role_id"], name: "index_accounts_roles_on_account_id_and_role_id", using: :btree

  create_table "addresses", force: :cascade do |t|
    t.string   "street_address",                null: false
    t.string   "street_address2",  default: "", null: false
    t.string   "city",                          null: false
    t.string   "state",                         null: false
    t.string   "zip",                           null: false
    t.integer  "addressable_id"
    t.string   "addressable_type"
    t.datetime "created_at",                    null: false
    t.datetime "updated_at",                    null: false
  end

  create_table "emails", force: :cascade do |t|
    t.string   "email",          null: false
    t.integer  "emailable_id"
    t.string   "emailable_type"
    t.datetime "created_at",     null: false
    t.datetime "updated_at",     null: false
  end

  create_table "invites", force: :cascade do |t|
    t.integer  "organization_id"
    t.string   "email"
    t.integer  "inviting_user"
    t.string   "identifier"
    t.datetime "created_at",      null: false
    t.datetime "updated_at",      null: false
    t.string   "kind"
    t.string   "first_name"
    t.string   "last_name"
  end

  create_table "invoices", force: :cascade do |t|
    t.integer  "project_id"
    t.string   "identifier"
    t.date     "date"
    t.date     "due_date"
    t.integer  "discount"
    t.integer  "discount_timeframe"
    t.text     "notes"
    t.datetime "created_at",                         null: false
    t.datetime "updated_at",                         null: false
    t.integer  "to_org_id"
    t.boolean  "paid",               default: false
    t.boolean  "active",             default: true
  end

  create_table "line_items", force: :cascade do |t|
    t.integer  "invoice_id"
    t.string   "item"
    t.text     "description"
    t.decimal  "amount"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
  end

  create_table "organizations", force: :cascade do |t|
    t.string   "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.hstore   "details"
  end

  create_table "partners", force: :cascade do |t|
    t.integer  "organization_id"
    t.integer  "vendor_id"
    t.integer  "client_id"
    t.datetime "created_at",      null: false
    t.datetime "updated_at",      null: false
  end

  create_table "phones", force: :cascade do |t|
    t.string   "phone_number",  null: false
    t.integer  "callable_id"
    t.string   "callable_type"
    t.datetime "created_at",    null: false
    t.datetime "updated_at",    null: false
  end

  create_table "project_orgs", id: false, force: :cascade do |t|
    t.integer "project_id",      null: false
    t.integer "organization_id", null: false
    t.string  "role"
  end

  create_table "projects", force: :cascade do |t|
    t.string   "name"
    t.string   "identifier"
    t.date     "start_date"
    t.date     "end_date"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer  "owner_id"
  end

  create_table "roles", force: :cascade do |t|
    t.string   "name"
    t.integer  "resource_id"
    t.string   "resource_type"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "roles", ["name", "resource_type", "resource_id"], name: "index_roles_on_name_and_resource_type_and_resource_id", using: :btree
  add_index "roles", ["name"], name: "index_roles_on_name", using: :btree

  create_table "users", force: :cascade do |t|
    t.string   "first_name"
    t.string   "last_name"
    t.integer  "organization_id"
    t.integer  "account_id",      null: false
    t.datetime "created_at",      null: false
    t.datetime "updated_at",      null: false
  end

  add_index "users", ["account_id"], name: "index_users_on_account_id", using: :btree
  add_index "users", ["organization_id"], name: "index_users_on_organization_id", using: :btree

  add_foreign_key "users", "accounts"
  add_foreign_key "users", "organizations"
end
