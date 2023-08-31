module Dibuk::Response
  class Sent < Base
    SUCCESS_HTTP_STATUSES = [200].freeze
    SUCCESS_STATUSES = [
        'OK'
    ].freeze

    WRONG_EMAIL_CODES = [
        '2010', #email is not valid
        '2011', #email domain is not supported
    ].freeze

    NOT_AVAILABLE_FORMAT_CODES = [
        '2012', #format for this email is not available
        '2022', #PDF size is limited to 50MB
    ].freeze

    def wrong_email?
      self.class::WRONG_EMAIL_CODES.include?(status)
    end

    def not_available_format?
      self.class::NOT_AVAILABLE_FORMAT_CODES.include?(status)
    end
  end
end