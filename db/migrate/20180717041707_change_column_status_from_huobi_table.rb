class ChangeColumnStatusFromHuobiTable < ActiveRecord::Migration[5.2]
  def change
    reversible do |dir|
      dir.up do
        change_column :huobi_pro_symbols, :status, :integer, index: true, limit: 2
        change_column :huobi_pro_symbols, :buy_time, :datetime, null: false, default: -> { 'CURRENT_TIMESTAMP' }
        change_column :huobi_pro_transactions, :status, :integer, index: true, limit: 2
      end

      dir.down do
        change_column :huobi_pro_symbols, :status, :boolean, index: true, default: false
        change_column :huobi_pro_symbols, :buy_time, :datetime, null: false
        change_column :huobi_pro_transactions, :status, :boolean, index: true, default: false
      end
    end
  end
end
