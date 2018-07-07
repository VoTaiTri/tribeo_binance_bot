class HuobiProTransaction < ApplicationRecord
  belongs_to :symbol, class_name: 'HuobiProSymbol'
end
