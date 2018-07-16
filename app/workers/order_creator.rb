module OrderCreator
  SELL_LIMIT = 'sell-limit'.freeze
  BUY_LIMIT = 'buy-limit'.freeze

  def initialize
    @form = Form::HuobiPro.new
  end

  def create_sell_order
    form = Form::HuobiPro.new
    HuobiProSymbol.trading.each do |token|
      trade_symbol = "#{token.symbol}#{token.symbol_base}"
      range = form.range_market_trade_of(trade_symbol)
      amount = form.my_balance_of(token.symbol)['balance']

      if token.stoploss <= range[:min]
        form.new_order(trade_symbol, SELL_LIMIT, (range[:min] * 0.995).round(3), (amount * 0.9975).round(2))
      end

      if token.target1 <= range[:max]
       form.new_order(trade_symbol, SELL_LIMIT, (range[:min] * 0.997).round(3), (amount * 0.9975).round(2))
      end
    end
  end

  def create_buy_order
    form = Form::HuobiPro.new
    HuobiProSymbol.waiting.each do |token|
      trade_symbol = "#{token.symbol}#{token.symbol_base}"
      buget = form.my_balance_of(token.symbol_base)['balance']

      range = form.range_market_trade_of(trade_symbol)
    end
  end
end
