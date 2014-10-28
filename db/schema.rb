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

ActiveRecord::Schema.define(version: 20141028225048) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "chats", force: true do |t|
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "messages", force: true do |t|
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

end
