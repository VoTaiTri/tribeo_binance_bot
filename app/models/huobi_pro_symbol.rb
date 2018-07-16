class HuobiProSymbol < ApplicationRecord
  has_many :transactions, class_name: 'HuobiProTransaction'

  validates :symbol, :symbol_base, :buy_price, :buy_amount, :buy_time, presence: true

  enum status: [:trading, :waiting, :done, :stop]

  scope :trading, -> { where(status: true) }

  scope :waiting, -> { where(status: false) }
end
