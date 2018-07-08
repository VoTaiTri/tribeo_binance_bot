class HuobiProTransaction < ApplicationRecord
  belongs_to :symbol, class_name: 'HuobiProSymbol', foreign_key: :huobi_pro_symbol_id, validate: true

  validates :order_id, :sell_price, :sell_amount, :sell_time, presence: true

  enum sell_type: { stoploss: 0, target1: 1, target2: 2, target3: 3 }
end
