class CreateHuobiProTransactions < ActiveRecord::Migration[5.1]
  def change
    create_table :huobi_pro_transactions do |t|
      t.references :huobi_pro_symbol, index: true
      t.integer :type, index: true, limit: 1, default: 0
      t.float :sell_price
      t.float :sell_amount
      t.datetime :sell_time
      t.float :profit
      t.boolean :status, index: true, default: false

      t.timestamps null: false
    end
  end
end
