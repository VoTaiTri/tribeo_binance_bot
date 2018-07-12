ass OrderCreator
	SELL_LIMIT = 'sell-limit'.freeze

	def create
		form = Form::HuobiPro.new
		HuobiProSymbol.trading.each do |token|
			trade_symbol = "#{token.symbol}#{token.symbol_base}"
			range = form.range_market_trade_of(trade_symbol)
			amount = form.my_balance_of(token.symbol)['balance']

			if token.stoploss <= range[:min]
				form.new_order(trade_symbol, SELL_LIMIT, range[:min] * 0.995, amount * 0.997)
			end

			if token.target1 <= range[:max]
		end
	end
end

