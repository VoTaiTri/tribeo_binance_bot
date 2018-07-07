class HuobiProSymbol < ApplicationRecord
  has_many :transactions, class_name: 'HuobiProTransaction'
end
