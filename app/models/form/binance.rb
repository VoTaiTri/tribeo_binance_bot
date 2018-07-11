require 'json'
require 'open-uri'
require 'digest/md5'
require 'base64'
require 'httparty'
require 'date'
require 'openssl'

include HTTParty

class Form::Binance
  def initialize
    @access_key = ENV['BINANCE_ACCESS_KEY']
    @secret_key = ENV['BINANCE_SECRET_KEY']
    #@signature_version = ENV['BINANCE_SIGNATURE_VERSION']
    #@account_id = ENV['BINANCE_ACCOUNT_ID']
    @uri = URI.parse(ENV['BINANCE_API_URL'])
    @headers = {
        'Content-Type' => 'application/json',
        'Accept'       => 'application/json',
        'Language'     => 'en',
        'User-Agent'   => 'Mozilla/5.0 (Windows NT 6.1; WOW64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/39.0.2171.71 Safari/537.36'
      }
  end

end
