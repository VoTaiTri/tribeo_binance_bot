class CreateHuobiProTransactions < ActiveRecord::Migration[5.1]
  def change
    create_table :huobi_pro_transactions do |t|
      t.references :huobi_pro_symbol, index: true, null: false
      t.decimal :order_id, precision: 15, scale: 0, null: false
      t.integer :type, index: true, limit: 1, default: 0
      t.float :sell_price, limit: 15, null: false
      t.float :sell_amount, limit: 20, null: false
      t.datetime :sell_time, null: false
      t.float :profit, limit: 10, null: false
      t.boolean :status, index: true, default: false

      t.timestamps null: false
    end
  end
end
