module Dibuk::Request
  class Base

    def method
      'POST'
    end

    def body
      ''
    end

    def headers
      {
          'Content-Type' => 'application/json',
          #'Authorization' => "Bearer #{client.auth_token}"
      }
    end

    # @return [String]
    def action
      raise 'Action should be implemented'
    end
  end
end