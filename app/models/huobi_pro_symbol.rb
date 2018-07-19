class HuobiProSymbol < ApplicationRecord
  has_many :transactions, class_name: 'HuobiProTransaction'

  validates :symbol, :symbol_base, :stoploss, :target1, :status, presence: true
  validates :buy_price, :buy_amount, :buy_time, presence: true, if: :trading?
  validates :wait_price, presence: true, if: :waiting?
  validate :target_have_to_greater_than_stoploss

  enum status: [:beginner, :trading, :waiting, :done, :canceled, :failure]

  private

  def target_have_to_greater_than_stoploss
    return if stoploss.present? && target1.present? && stoploss < target1
    errors.add :base, 'target have to greater than stoploss' if stoploss >= target1
  end
end
