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

ActiveRecord::Schema.define(version: 20150831221258) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "chats", force: :cascade do |t|
    t.integer  "client_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "chats", ["client_id"], name: "index_chats_on_client_id", using: :btree

  create_table "clients", force: :cascade do |t|
    t.string   "phone_number"
    t.string   "name"
    t.text     "address"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.boolean  "general_information_requested",         default: false
    t.string   "country"
    t.date     "birthday"
    t.string   "language"
    t.integer  "num_children"
    t.boolean  "has_unwanted",                          default: false
    t.string   "confirmation_method"
    t.text     "notes"
    t.boolean  "confirmed_pregnancy"
    t.datetime "normal_period_start_day"
    t.boolean  "termination_chosen"
    t.boolean  "informed_risks_pills"
    t.boolean  "informed_iud"
    t.text     "informed_iud_statement"
    t.boolean  "other_illness"
    t.boolean  "other_std"
    t.boolean  "previous_termination_attempt"
    t.boolean  "previous_termination_attempt_bleeding"
  end

  create_table "code_batches", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "code_usages", force: :cascade do |t|
    t.integer  "code_id"
    t.integer  "client_id"
    t.datetime "created_at",        null: false
    t.datetime "updated_at",        null: false
    t.integer  "code_validator_id"
  end

  add_index "code_usages", ["client_id"], name: "index_code_usages_on_client_id", using: :btree
  add_index "code_usages", ["code_id"], name: "index_code_usages_on_code_id", using: :btree
  add_index "code_usages", ["code_validator_id"], name: "index_code_usages_on_code_validator_id", using: :btree

  create_table "code_validators", force: :cascade do |t|
    t.integer  "max_redemptions"
    t.integer  "max_unique_redemptions"
    t.datetime "created_at",             null: false
    t.datetime "updated_at",             null: false
  end

  create_table "codes", force: :cascade do |t|
    t.string   "code"
    t.integer  "code_validator_id"
    t.integer  "code_batch_id"
    t.datetime "created_at",        null: false
    t.datetime "updated_at",        null: false
  end

  add_index "codes", ["code_batch_id"], name: "index_codes_on_code_batch_id", using: :btree
  add_index "codes", ["code_validator_id"], name: "index_codes_on_code_validator_id", using: :btree

  create_table "consultation_questions", force: :cascade do |t|
    t.text     "preview"
    t.text     "question"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "locale"
  end

  create_table "diagnosed_health_problems", force: :cascade do |t|
    t.integer  "health_problem_id"
    t.integer  "client_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "diagnosed_health_problems", ["client_id"], name: "index_diagnosed_health_problems_on_client_id", using: :btree
  add_index "diagnosed_health_problems", ["health_problem_id"], name: "index_diagnosed_health_problems_on_health_problem_id", using: :btree

  create_table "faqs", force: :cascade do |t|
    t.text     "question"
    t.text     "answer"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "locale"
  end

  create_table "follow_up_questions", force: :cascade do |t|
    t.text     "question"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "locale"
  end

  create_table "health_problems", force: :cascade do |t|
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "locale"
  end

  create_table "messages", force: :cascade do |t|
    t.string   "from"
    t.string   "to"
    t.text     "message"
    t.datetime "sent_at"
    t.boolean  "sent"
    t.boolean  "delivered"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.boolean  "sent_by_system"
    t.string   "relayer"
    t.integer  "chat_id"
  end

  add_index "messages", ["chat_id"], name: "index_messages_on_chat_id", using: :btree

  create_table "order_updates", force: :cascade do |t|
    t.string   "confirmation_code"
    t.integer  "user_id"
    t.integer  "order_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "order_updates", ["order_id"], name: "index_order_updates_on_order_id", using: :btree
  add_index "order_updates", ["user_id"], name: "index_order_updates_on_user_id", using: :btree

  create_table "orders", force: :cascade do |t|
    t.string   "beneficiary_number"
    t.float    "subtotal"
    t.float    "shipping"
    t.float    "taxes"
    t.string   "state"
    t.integer  "client_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "orders", ["client_id"], name: "index_orders_on_client_id", using: :btree

  create_table "push_notifications", force: :cascade do |t|
    t.string   "tag"
    t.text     "message"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "sent_push_notifications", force: :cascade do |t|
    t.integer  "push_notification_id"
    t.integer  "client_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "sent_push_notifications", ["client_id"], name: "index_sent_push_notifications_on_client_id", using: :btree
  add_index "sent_push_notifications", ["push_notification_id"], name: "index_sent_push_notifications_on_push_notification_id", using: :btree

  create_table "subscriptions", force: :cascade do |t|
    t.integer  "user_id"
    t.integer  "chat_id"
    t.datetime "last_read_at"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "subscriptions", ["chat_id"], name: "index_subscriptions_on_chat_id", using: :btree
  add_index "subscriptions", ["user_id"], name: "index_subscriptions_on_user_id", using: :btree

  create_table "users", force: :cascade do |t|
    t.string   "email",                  default: "",    null: false
    t.string   "encrypted_password",     default: "",    null: false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          default: 0,     null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.inet     "current_sign_in_ip"
    t.inet     "last_sign_in_ip"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.boolean  "is_admin",               default: false
    t.string   "locale"
  end

  add_index "users", ["email"], name: "index_users_on_email", unique: true, using: :btree
  add_index "users", ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true, using: :btree

  create_table "versions", force: :cascade do |t|
    t.string   "item_type",  null: false
    t.integer  "item_id",    null: false
    t.string   "event",      null: false
    t.string   "whodunnit"
    t.text     "object"
    t.datetime "created_at"
  end

  add_index "versions", ["item_type", "item_id"], name: "index_versions_on_item_type_and_item_id", using: :btree

  add_foreign_key "code_usages", "clients"
  add_foreign_key "code_usages", "code_validators"
  add_foreign_key "code_usages", "codes"
  add_foreign_key "codes", "code_batches"
  add_foreign_key "codes", "code_validators"
end
