class HuobiProSymbol < ApplicationRecord
  has_many :transactions, class_name: 'HuobiProTransaction'

  validates :symbol, :symbol_base, :buy_price, :buy_amount, :buy_time, presence: true

  scope :trading, -> { where(status: true) }

  def is_trading?
    status
  end
end
