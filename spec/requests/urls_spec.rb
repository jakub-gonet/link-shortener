# frozen_string_literal: true

require 'rails_helper'
require 'support'

RSpec.describe 'urls#create', type: :request do
  context 'when valid url is provided' do
    before { post '/urls', params: url_params(VALID_URL) }

    it 'redirects to url page' do
      expect(response).to redirect_to %r{urls/\w+-\w+-\w+}
    end
    it 'have 200 HTPP status' do
      follow_redirect!

      expect(response).to have_http_status(:ok)
    end
  end
  it 'shows forbidden domain error on root page when url from forbidden domain is provided' do
    post '/urls', params: url_params(URL_FORBIDDEN_DOMAIN)

    expect(response).to redirect_to root_path

    follow_redirect!

    expect(response.body).to include('Origin: domain')
  end
  it 'shows malformed url error on root page when invalid url is provided' do
    post '/urls', params: url_params(INVALID_URL)

    expect(response).to redirect_to root_path

    follow_redirect!

    expect(response.body).to include('Origin: url')
    expect(response.body).to include('malformed')
  end
  it 'shows blank url error on root page when url is not provided' do
    post '/urls', params: url_params('')

    expect(response).to redirect_to root_path

    follow_redirect!

    expect(response.body).to include('Origin: url')
    expect(response.body).to include('blank')
  end
end

RSpec.describe 'urls#show', type: :request do
  it 'shows base and shortened link when valid shortened slug is provided' do
    url = create_url(VALID_URL)

    get "/urls/#{url.shortened_url}"

    expect(response.body).to include(url.base_url, url.shortened_url)
  end
  it 'show empty view page when given url is not found' do
    get '/urls/not_shortened'

    expect(response.body).not_to include('<li>')
  end
end

RSpec.describe 'urls#index', type: :request do
  it "shows only last #{UrlsController::RECENT_URLS_COUNT} shortened links" do
    to_show = UrlsController::RECENT_URLS_COUNT
    range = 1..(to_show + 5)
    range.each {|n| create_url("#{VALID_URL}-#{n}") }

    get '/urls'

    # contains `to_show` list items
    expect(response.body.scan(%r{<li>.+</li>}).size).to eq(to_show)
  end
  it 'shows nothing if no links were created' do
    get '/urls'

    expect(response.body).not_to include('<li>')
  end
end
