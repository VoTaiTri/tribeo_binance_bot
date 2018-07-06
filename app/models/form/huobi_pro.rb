

# require 'httparty'
require 'json'
require 'open-uri'
require 'rack'
require 'digest/md5'
require 'base64'

class Form::HuobiPro
  def initialize
      @access_key = ENV['HUOBI_ACCESS_KEY']
      @secret_key = ENV['HUOBI_SECRET_KEY']
      @signature_version = ENV['HUOBI_SIGNATURE_VERSION']
      @account_id = ENV['HUOBI_ACCOUNT_ID']
      @uri = URI.parse(ENV['HUOBI_URL'])
      @headers = {
        'Content-Type' => 'application/json',
        'Accept'       => 'application/json',
        'Language'     => 'en',
        'User-Agent'   => 'Mozilla/5.0 (Windows NT 6.1; WOW64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/39.0.2171.71 Safari/537.36'
      }
  end

  # Danh sach tat ca cac cap trade
  def symbols
    path = '/v1/common/symbols'
    request_method = 'GET'
    params = {}
    perform(path, params, request_method)
  end

  # Thong tin cu the cua tung nen tren chart theo khung tgian, so luong nen
  # Response: open, close, low, hight
  def history_kline symbol, period, size = 150
    path = '/market/history/kline'
    request_method = 'GET'
    params = { 'symbol' => symbol, 'period' => period, 'size' => size }
    perform(path, params, request_method)
  end

  # Gia tong hop trong 1 khoang tgian, cac lenh da khop
  def merged symbol
    path = '/market/detail/merged'
    request_method = 'GET'
    params = { 'symbol' => symbol }
    perform(path, params, request_method)
  end

  # Gia tong hop cua ca san
  def market_tickers
    path = '/market/tickers'
    request_method = 'GET'
    perform(path, {}, request_method)
  end

  # List lenh hoi mua/ban, ask/bid, cac lenh dang cho giao dich
  # type = step0, step1, step2, step3, step4, step5
  def depth symbol, type = 'step0'
    path = '/market/depth'
    request_method = 'GET'
    params = { 'symbol' => symbol, 'type' => type }
    perform(path, params, request_method)
  end

  def market_trade symbol
    path = '/market/trade'
    request_method = 'GET'
    params = { 'symbol' => symbol }
    perform(path, params, request_method)
  end

  # Size form 1 to 2000
  def history_trade symbol, size = 1
    path = '/market/history/trade'
    request_method = 'GET'
    params = { 'symbol' => symbol, 'size' => size }
    perform(path, params, request_method)
  end

  # get max and min of market
  def range_market_trade_of symbol, size = 1000
    datas = history_trade(symbol, size)['data'].flat_map{ |x| x['data'] }

    max_trade = datas.max_by{ |mx| mx['price'] }['price']
    min_trade = datas.min_by{ |mn| mn['price'] }['price']
    [min_trade, max_trade]
  end

  # Tong hop gia ca thi truong trong 24h
  def market_detail symbol
    path = '/market/detail'
    request_method = 'GET'
    params = { 'symbol' => symbol }
    perform(path, params, request_method)
  end

  # 获取 Trade Detail 数据
  def trade_detail symbol
    path = '/market/detail'
    request_method = 'GET'
    params = { 'symbol' => symbol }
    perform(path, params, request_method)
  end

  # List all currencys's supported
  def currencys
    path = '/v1/common/currencys'
    request_method = 'GET'
    params = {}
    perform(path, params, request_method)
  end

  # Check your account detail
  # Require: login
  def accounts
    path = '/v1/account/accounts'
    request_method = 'GET'
    params = {}
    perform(path, params, request_method)
  end

  # Check your balances detail
  # Require: login and account-id
  def my_balances
    path = "/v1/account/accounts/#{@account_id}/balance"
    request_method = 'GET'
    # balances = { 'account_id' => @account_id }
    perform(path, {}, request_method)
  end

  def my_balance_of coin
    my_balances['data']['list'].detect do |balance|
      balance['currency'] == coin && balance['type'] == 'trade'
    end
  end

  # Create new order
  # Return data = order_id
  def new_order symbol, trade_type, price, amount
    path = '/v1/order/orders/place'
    request_method = 'POST'
    params = {
      'account-id' => @account_id,
      'amount' => amount,
      'price' => price,
      'source' => 'api',
      'symbol' => symbol,
      'type' => trade_type
    }
    perform(path, params, request_method)
  end

  # Cancel order by order_id
  # Return data = order_id
  def submit_cancel order_id
    path = "/v1/order/orders/#{order_id}/submitcancel"
    request_method = 'POST'
    params = { 'order-id' => order_id }
    perform(path, params, request_method)
  end

  # Batch cancel order
  def batch_cancel order_ids
    path = '/v1/order/orders/batchcancel'
    request_method = 'POST'
    params = { 'order-ids' => order_ids }
    perform(path, params, request_method)
  end

  # Check order detail by order_id
  def order_status order_id
    path = "/v1/order/orders/#{order_id}"
    request_method = 'GET'
    params = { 'order-id' => order_id }
    perform(path, params, request_method)
  end

  # ## 申请提现虚拟币
  # def withdraw_virtual_create(address,amount,currency)
  #   path = "/v1/dw/withdraw/api/create"
  #   params ={
  #     "address" =>address,
  #     "amount" => amount,
  #     "currency" => currency
  #   }
  #   request_method = "POST"
  #   perform(path,params,request_method)
  # end

  # ## 申请取消提现虚拟币
  # def withdraw_virtual_cancel(withdraw_id)
  #   path = "/v1/dw/withdraw-virtual/#{withdraw_id}/cancel"
  #   params ={"withdraw_id" => withdraw_id}
  #   request_method = "POST"
  #   perform(path,params,request_method)
  # end

  # ## 查询某个订单的成交明细
  # def matchresults(order_id)
  #   path = "/v1/order/orders/#{order_id}/matchresults"
  #   request_method = 'GET'
  #   params ={"order-id" => order_id}
  #   perform(path,params,request_method)
  # end

  # ## 查询当前委托、历史委托
  # def open_orders(symbol,side)
  #   params ={
  #     "symbol" => symbol,
  #     "types" => "#{side}-limit",
  #     "states" => "pre-submitted,submitted,partial-filled,partial-canceled"
  #   }
  #   path = "/v1/order/orders"
  #   request_method = 'GET'
  #   perform(path,params,request_method)
  # end

  # ## 查询当前成交、历史成交
  # def history_matchresults symbol
  #   path = "/v1/order/matchresults"
  #   params ={"symbol"=>symbol}
  #   request_method = 'GET'
  #   perform(path,params,request_method)
  # end

  # ## 现货账户划入至借贷账户
  # def transfer_in_margin(symbol,currency,amount)
  #   path = "/v1/dw/transfer-in/margin"
  #   params ={"symbol"=>symbol,"currency"=>currency,"amount"=>amount}
  #   request_method = "POST"
  #   perform(path,params,request_method)
  # end

  # ## 借贷账户划出至现货账户
  # def transfer_out_margin(symbol,currency,amount)
  #   path = "/v1/dw/transfer-out/margin"
  #   params ={"symbol"=>symbol,"currency"=>currency,"amount"=>amount}
  #   request_method = "POST"
  #   perform(path,params,request_method)
  # end

  # ## 借贷订单
  # def loan_orders(symbol,currency)
  #   path = "/v1/margin/loan-orders"
  #   params ={"symbol"=>symbol,"currency"=>currency}
  #   request_method = "POST"
  #   perform(path,params,request_method)
  # end

  # ## 归还借贷
  # def repay(order_id,amount)
  #   path = "/v1/margin/orders/{order-id}/repay"
  #   params ={"order-id"=>order_id,"amount"=>amount}
  #   request_method = 'GET'
  #   perform(path,params,request_method)
  # end
  # ## 借贷账户详情
  # def margin_accounts_balance symbol
  #   path = "/v1/margin/accounts/balance?symbol={symbol}"
  #   params ={}
  #   request_method = 'GET'
  #   perform(path,params,request_method)
  # end
  # ## 申请借贷
  # def margin_orders(symbol,currency,amount)
  #   path = "/v1/margin/orders"
  #   params ={"symbol"=>symbol,"currency"=>currency,"amount"=>amount}
  #   request_method = "POST"
  #   perform(path,params,request_method)
  # end

  private

  def perform path, params, request_method
    header =  {
      'AccessKeyId'      => @access_key,
      'SignatureMethod'  => 'HmacSHA256',
      'SignatureVersion' => @signature_version,
      'Timestamp'        => Time.now.getutc.strftime('%Y-%m-%dT%H:%M:%S')
    }
    header = header.merge(params) if request_method == 'GET'
    data = "#{request_method}\napi.huobi.pro\n#{path}\n#{Rack::Utils.build_query(hash_sort(header))}"
    header['Signature'] = sign(data)

    url = "https://api.huobi.pro#{path}?#{Rack::Utils.build_query(header)}"
    http = Net::HTTP.new(@uri.host, @uri.port)
    http.use_ssl = true

    response = http.send_request(request_method, url, JSON.dump(params), @headers).body
    JSON.parse response
  rescue Exception => e
    { 'message' => 'error' ,'request_error' => e.message }
  end

  def sign data
    Base64.encode64(OpenSSL::HMAC.digest('sha256', @secret_key, data)).gsub("\n",'')
  end

  def hash_sort header
    Hash[header.sort_by{ |key, _v| key }]
  end
end
