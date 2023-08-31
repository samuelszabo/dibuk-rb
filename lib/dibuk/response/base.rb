module Dibuk::Response
  class Base
    extend Dry::Initializer::Mixin

    option :http_response

    SUCCESS_HTTP_STATUSES = [200].freeze
    SUCCESS_STATUSES = ['SUCCESS'].freeze

    def success?
      http_success? && status_success?
    end

    def error?
      !success?
    end

    def error_code
      return unless error?
      body[:eNum].to_s
    end

    def error_data
      return unless error?
      body[:eData]
    end

    def limit_exceeded?
      error_code == '2015'
    end

    def not_buyed?
      error_code == '2004'
    end

    def body
      return unless raw_body
      @body ||=
          begin
            JSON.parse(raw_body, symbolize_names: true)
          rescue => e
            raise InvalidResponseError, e.message
          end
    end

    def http_status_ok
      @http_status_ok ||= http_response.instance_of? Net::HTTPOK
    end

    private

    def http_success?
      http_status_ok
    end

    def status_success?
      self.class::SUCCESS_STATUSES.include?(status)
    end

    def status
      body[:status] || ''
    end

    def raw_body
      @raw_body ||= http_response.body
    end
  end
end