class CreateHuobiProSymbols < ActiveRecord::Migration[5.1]
  def change
    create_table :huobi_pro_symbols do |t|
      t.string :symbol, limit: 15, index: true, null: false
      t.float :buy_price, null: false
      t.float :buy_amount, null: false
      t.datetime :buy_time, null: false
      t.float :target1
      t.float :target2
      t.float :target3
      t.float :stoploss
      t.float :profit
      t.boolean :status, index: true, default: false

      t.timestamps null: false
    end
  end
end
