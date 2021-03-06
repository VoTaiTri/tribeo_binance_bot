class CreateHuobiProSymbols < ActiveRecord::Migration[5.1]
  def change
    create_table :huobi_pro_symbols do |t|
      t.decimal :order_id, precision: 15, scale: 0
      t.string :symbol, limit: 8, index: true
      t.string :symbol_base, limit: 8, index: true
      t.float :buy_price, limit: 15
      t.float :buy_amount, limit: 20
      t.datetime :buy_time, null: false
      t.float :target1, limit: 15
      t.float :target2, limit: 15
      t.float :target3, litmit: 15
      t.float :stoploss, limit: 15
      t.float :profit, limit: 10
      t.boolean :status, index: true, default: false

      t.timestamps null: false
    end
  end
end
