module Dibuk::Request
  class License < Base
    # @param [User] user
    # @param [Item] item
    # @return [self]
    def initialize(user, item)
      @item = item
      @user = user
    end

    def body
      {
          :book_id => @item.id,
          :user_id => @user.id,
          :user_email => @user.email,
          :user_order => @item.order_id,
          :seller_price => @item.price,
          :payment_channel => @item.payment_id,
          :user_name => @user.name,
          :user_surname => @user.surname,
          :uniq_license_id => @item.unique_id,
      }
    end

    # @return [String]
    def action
      'buy'
    end
  end
end