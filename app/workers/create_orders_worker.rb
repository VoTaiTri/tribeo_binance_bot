class CreateOrdersWorker
  include Sidekiq::Worker
  include OrderCreator

  def perform(*args)
    create_sell_order
  end
end
