module Dibuk::Request
  class Links < Base
    # @param [User] user
    # @param [Item] item
    def initialize(user, item)
      @item = item
      @user = user
    end

    def body
      {
          :book_id => @item.id,
          :user_id => @user.id,
          :user_name => @user.name,
          :user_surname => @user.surname,
          :user_email => @user.email,
      }
    end

    # @return [String]
    def action
      'downloadLinks'
    end
  end
end
