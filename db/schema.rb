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

ActiveRecord::Schema.define(version: 2018_07_06_101611) do

  create_table "huobi_pro_symbols", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci", force: :cascade do |t|
    t.decimal "order_id", precision: 15, null: false
    t.string "symbol", limit: 8, null: false
    t.string "symbol_base", limit: 8, null: false
    t.float "buy_price", null: false
    t.float "buy_amount", null: false
    t.datetime "buy_time", null: false
    t.float "target1"
    t.float "target2"
    t.float "target3"
    t.float "stoploss"
    t.float "profit"
    t.boolean "status", default: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["status"], name: "index_huobi_pro_symbols_on_status"
    t.index ["symbol"], name: "index_huobi_pro_symbols_on_symbol"
    t.index ["symbol_base"], name: "index_huobi_pro_symbols_on_symbol_base"
  end

  create_table "huobi_pro_transactions", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci", force: :cascade do |t|
    t.bigint "huobi_pro_symbol_id", null: false
    t.decimal "order_id", precision: 15, null: false
    t.integer "type", limit: 1, default: 0
    t.float "sell_price", null: false
    t.float "sell_amount", null: false
    t.datetime "sell_time", null: false
    t.float "profit", null: false
    t.boolean "status", default: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["huobi_pro_symbol_id"], name: "index_huobi_pro_transactions_on_huobi_pro_symbol_id"
    t.index ["status"], name: "index_huobi_pro_transactions_on_status"
    t.index ["type"], name: "index_huobi_pro_transactions_on_type"
  end

end
