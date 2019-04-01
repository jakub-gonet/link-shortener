# frozen_string_literal: true

require 'rails_helper'

VALID_URL = 'https://youtu.be/dQw4w9WgXcQ'
VALID_IP = '127.0.0.1'

RSpec.describe UrlAccess, type: :model do
  describe 'validation' do
    context 'with valid url model' do
      let(:url) { Url.create!(base_url: VALID_URL) }

      it 'is valid when IP address is provided' do
        url_access = url.url_accesses.create(ip: VALID_IP)
        expect(url_access).to be_valid
      end
      it 'is invalid when IP address is not provided' do
        url_access = url.url_accesses.create(ip: nil)
        expect(url_access).to_not be_valid
      end
    end
  end
end
