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

ActiveRecord::Schema.define(version: 20170419051642) do

  create_table "addresses", force: :cascade do |t|
    t.string   "street address", limit: 100
    t.string   "city",           limit: 50
    t.string   "state",          limit: 50
    t.string   "zip",            limit: 10
    t.datetime "created_at",                 null: false
    t.datetime "updated_at",                 null: false
  end

  create_table "auction_locations", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer  "auction_id"
    t.integer  "address_id"
    t.index ["address_id"], name: "index_auction_locations_on_address_id", using: :btree
    t.index ["auction_id"], name: "index_auction_locations_on_auction_id", using: :btree
  end

  create_table "auctions", force: :cascade do |t|
    t.string   "auction name"
    t.datetime "created_at",   null: false
    t.datetime "updated_at",   null: false
  end

  create_table "bids", force: :cascade do |t|
    t.datetime "created_at",    null: false
    t.datetime "updated_at",    null: false
    t.bigint   "winning bid"
    t.bigint   "seller payout"
    t.integer  "auction_id"
    t.integer  "stock_id"
    t.bigint   "profit"
    t.index ["auction_id"], name: "index_bids_on_auction_id", using: :btree
    t.index ["stock_id"], name: "index_bids_on_stock_id", using: :btree
  end

  create_table "stock", force: :cascade do |t|
    t.string   "vehicle stock number"
    t.string   "description"
    t.datetime "created_at",           null: false
    t.datetime "updated_at",           null: false
    t.integer  "auction_id"
    t.integer  "vehicle_id"
    t.index ["auction_id"], name: "index_stock_on_auction_id", using: :btree
    t.index ["vehicle_id"], name: "index_stock_on_vehicle_id", using: :btree
  end

  create_table "vehicles", force: :cascade do |t|
    t.string   "vehicle make"
    t.string   "vehicle year"
    t.string   "vehicle model"
    t.datetime "created_at",    null: false
    t.datetime "updated_at",    null: false
  end

  add_foreign_key "auction_locations", "addresses"
  add_foreign_key "auction_locations", "auctions"
  add_foreign_key "bids", "auctions"
  add_foreign_key "bids", "stock"
  add_foreign_key "stock", "auctions"
  add_foreign_key "stock", "vehicles"
end
