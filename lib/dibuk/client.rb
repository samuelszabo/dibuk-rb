module Dibuk
  class Client
    extend Dry::Initializer::Mixin

    option :seller_id
    option :signature
    option :sandbox, default: proc { false }

    def license(user, item)
      request = Dibuk::Request::License.new(user, item)
      Dibuk::Response::Licensed.new(http_response: call(request))
    end

    def send(user, item, email)
      request = Dibuk::Request::Send.new(user, item, email)
      Dibuk::Response::Sent.new(http_response: call(request))
    end

    def links(user, item)
      request = Dibuk::Request::Links.new(user, item)
      Dibuk::Response::Linked.new(http_response: call(request))
    end

    private

    def call(request)
      http_request = Dibuk::HttpRequest.new(request: request, seller_id: seller_id, signature: signature, sandbox: sandbox)
      http_request.call
    end
  end
end
