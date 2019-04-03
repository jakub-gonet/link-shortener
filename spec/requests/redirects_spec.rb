# frozen_string_literal: true

require 'rails_helper'
require 'support'

RSpec.describe 'redirects#show', type: :request do
  context 'when shortened url exists' do
    let(:url) { create_url(VALID_URL) }
    it 'redirects to base url' do
      get "/r/#{url.shortened_url}"

      expect(response).to redirect_to(url.base_url)
    end
    it 'creates new url access object' do
      expect { get "/r/#{url.shortened_url}" }.to(change { UrlAccess.count })
    end
  end

  context 'when shortened url does not exist' do
    it 'renders 404 page' do
      get '/r/invalid'

      expect(response).to redirect_to '/404'
    end
    it 'does not create new url access object' do
      expect { get '/r/invalid' }.not_to(change { UrlAccess.count })
    end
  end
end
