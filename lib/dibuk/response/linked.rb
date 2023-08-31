# frozen_string_literal: true

module Dibuk::Response
  class Linked < Base
    SUCCESS_HTTP_STATUSES = [200].freeze
    SUCCESS_STATUSES = [
        'OK'
    ].freeze

    @@formats = {
        "3": {
            'title': 'EPUB',
            'code': 'epub',
            'mimetype': 'application/epub+zip'
        },
        "4": {
            'title': 'PDF',
            'code': 'pdf',
            'mimetype': 'application/pdf'
        },
        "5": {
            'title': 'MOBI',
            'code': 'mobi',
            'mimetype': 'application/x-mobipocket-ebook'
        },
        "1": {
            'title': 'EPUB (Adobe DRM)',
            'code': 'acs_epub',
            'mimetype': 'application/epub+zip'
        },
        "2": {
            'title': 'PDF (Adobe DRM)',
            'code': 'acs_pdf',
            'mimetype': 'application/pdf'
        },
        "6": {'title': 'EPUB', 'code': 'social_epub', 'mimetype': 'application/epub+zip'},
        "7": {'title': 'PDF', 'code': 'social_pdf', 'mimetype': 'application/pdf'},
        "8": {'title': 'MOBI', 'code': 'social_mobi', 'mimetype': 'application/x-mobipocket-ebook'},
        "9 ": {'title': 'MP3', 'code': 'mp3', 'mimetype': 'audio/mpeg'}
    }


    def all
      @formats || parse_formats
    end

    def epub
      get_format "epub"
    end

    private

    def parse_formats
      @formats || begin
                    @formats = {}
                    body[:data].each do |num, url|
                      @formats[@@formats[num][:code]] = url
                    end
                    @formats
                  end
    end

    # @param [String] format
    # @return [String] download url
    def get_format(format)
      parse_formats
      @formats[format]
    end
  end
end
