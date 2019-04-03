# frozen_string_literal: true

VALID_IP = '127.0.0.1'
VALID_URL = 'https://youtu.be/0qzLRlQFFQ4'
URL_FORBIDDEN_DOMAIN = 'http://bit.do/Sans'
INVALID_URL = 'somestring'

VALID_URLS = ['https://youtu.be/dQw4w9WgXcQ',
              'youtu.be/y6120QOlsfU',
              'example.com/%00'].freeze
INVALID_URLS = ['', 'badziebabla'].freeze

def url_params(base_url)
  {url: {base_url: base_url}}
end

def create_url(name = '')
  Url.create!(base_url: "#{VALID_URL}-#{name}")
end

def create_url_views(url_id, number, date)
  number.times do |_|
    access = UrlAccess.create!(url_id: url_id, ip: VALID_IP)
    access.created_at = date unless date.nil?
    access.save
  end
end
