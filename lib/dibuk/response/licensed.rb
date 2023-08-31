module Dibuk::Response
  class Licensed < Base
    SUCCESS_HTTP_STATUSES = [200].freeze
    SUCCESS_STATUSES = [
        'OK',
        'HAVEYET',
    ].freeze
  end
end