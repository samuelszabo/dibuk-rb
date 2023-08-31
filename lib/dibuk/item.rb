module Dibuk
  class Item
    extend Dry::Initializer::Mixin

    option :id
    option :order_id
    option :payment_id
    option :price
    option :currency
    option :unique_id
  end
end