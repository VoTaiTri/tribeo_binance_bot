class AddWaitPriceToHuobiProSymbols < ActiveRecord::Migration[5.2]
  def change
    add_column :huobi_pro_symbols, :wait_price, :float, limit: 15, after: :buy_time
  end
end
