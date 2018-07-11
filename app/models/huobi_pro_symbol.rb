class HuobiProSymbol < ApplicationRecord
  has_many :transactions, class_name: 'HuobiProTransaction'

  validates :symbol, :symbol_base, :buy_price, :buy_amount, :buy_time, presence: true
end
