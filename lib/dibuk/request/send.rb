module Dibuk::Request
  class Send < Base
    # @param [User] user
    # @param [Item] item
    # @param [string] email
    # @return [Response]
    def initialize(user, item, email)
      @item = item
      @user = user
      @email = email
    end

    # @return [Hash{Symbol->String}]
    def body
      {
          :book_id => @item.id,
          :send_to_email => @user.email,
          :user_id => @user.id,
          :user_name => @user.name,
          :user_surname => @user.surname,
          :user_email => @user.email,
      }
    end

    # @return [String]
    def action
      'sendByEmail'
    end
  end
end
