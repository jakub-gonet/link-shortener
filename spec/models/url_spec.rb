# frozen_string_literal: true

require 'rails_helper'
require 'support'

RSpec.describe(Url, type: :model) do
  describe 'validation' do
    VALID_URLS.each do |valid_url|
      it 'is valid when properly structured url' do
        url = Url.create(base_url: valid_url)
        expect(url).to be_valid
      end
    end

    it 'is invalid when url from forbidden domains' do
      url = Url.create(base_url: URL_FORBIDDEN_DOMAIN)
      expect(url).to_not be_valid
    end

    it 'is invalid when nil as url' do
      url = Url.create(base_url: nil)
      expect(url).to_not be_valid
    end

    it 'is invalid when empty string as url' do
      url = Url.create(base_url: '')
      expect(url).to_not be_valid
    end

    INVALID_URLS.each do |invalid_url|
      it 'is invalid when invalid structured url' do
        url = Url.create(base_url: invalid_url)
        expect(url).to_not be_valid
      end
    end
  end
end
