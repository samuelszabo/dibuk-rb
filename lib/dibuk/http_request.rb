module Dibuk
  class HttpRequest

    ENDPOINT_URL = 'https://agregator.dibuk.eu/2_3/call.php'.freeze
    ENDPOINT_SANDBOX_URL = 'https://sandbox.dibuk.eu/agregator/2_3/call.php'.freeze

    extend Dry::Initializer::Mixin

    option :request
    option :seller_id
    option :signature
    option :sandbox, default: proc { false }


    def call
      # pr endpoint
      # pr body_sign
      uri = URI(endpoint)

      net_http = Net::HTTP.new(uri.host, uri.port)
      net_http.use_ssl=true
      request = Net::HTTP::Post.new(uri)

      net_http.start do |http|
        post_data = URI.encode_www_form(body_sign)
        http.request(request, post_data)
      end
    end

    def endpoint
      sandbox? ? ENDPOINT_SANDBOX_URL : ENDPOINT_URL
    end

    def sandbox?
      sandbox
    end

    def body_sign
      params = {
          :a => request.action,
          :v => ::Dibuk::API_VERSION,
          :did => seller_id
      }
      request.body.each do |key, value|
        params[key] = value
      end

      query = ''
      params.each do |key, value|
        query += '&' unless query == ''
        query += key.to_s
        query += '=' + CGI.escape(value)
      end

      #ph = Faraday::Utils::ParamsHash.new
      #ph.update(params)
      #puts ph.to_query wrong, changing order of keys

      params[:ch] = OpenSSL::HMAC.hexdigest("sha1", Base64.decode64(signature), query)
      params
    end
  end
end