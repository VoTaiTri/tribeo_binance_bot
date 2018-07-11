class CreateHuobiProTransactions < ActiveRecord::Migration[5.1]
  def change
    create_table :huobi_pro_transactions do |t|
      t.references :huobi_pro_symbol, index: true 
      t.decimal :order_id, precision: 15, scale: 0
      t.integer :sell_type, index: true, limit: 1, default: 0
      t.float :sell_price, limit: 15
      t.float :sell_amount, limit: 20
      t.datetime :sell_time, null: false
      t.float :profit, limit: 10
      t.boolean :status, index: true, default: false

      t.timestamps null: false
    end
  end
end
