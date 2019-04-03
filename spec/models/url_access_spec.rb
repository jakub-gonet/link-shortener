# frozen_string_literal: true

require 'rails_helper'
require 'shared_examples'
require 'support'

RSpec.describe UrlAccess, type: :model do
  describe 'validation' do
    context 'with valid url model' do
      let(:url) {Url.create!(base_url: VALID_URL)}

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

  describe 'count_grouped_urls_views_since' do
    context 'with existing url views' do
      before do
        create_url_views(create_url(1).id, 3, DateTime.now)
        create_url_views(create_url(2).id, 1, DateTime.now - 3)
      end
      it 'returns views grouped by date' do
        data = UrlAccess.count_grouped_urls_views_since(DateTime.now - 7)

        expect(data.size).to eq(2)

        data.each do |k, _|
          expect {k.try(:to_date)}.not_to raise_error
        end
      end
      it_behaves_like 'a hash with elements' do
        let(:hash) {UrlAccess.count_grouped_urls_views_since(DateTime.now - 1)}
      end
    end

    context 'with urls but without views' do
      before do
        3.times(&method(:create_url))
      end
      it_behaves_like 'an empty hash' do
        let(:hash) {UrlAccess.count_grouped_urls_views_since(DateTime.now - 1)}
      end
    end

    context 'with url views older than provided date' do
      before do
        create_url_views(create_url.id, 3, DateTime.now - 7)
      end
      it_behaves_like 'an empty hash' do
        let(:hash) {UrlAccess.count_grouped_urls_views_since(DateTime.now - 5)}
      end
    end

    context 'without urls' do
      it_behaves_like 'an empty hash' do
        let(:hash) {UrlAccess.count_grouped_urls_views_since(DateTime.now - 5)}
      end
    end
  end

  describe 'count_url_views_since' do
    context 'with existing url views' do
      let(:shortened) do
        url = create_url
        create_url_views(url.id, 3, DateTime.now)
        create_url_views(url.id, 1, DateTime.now - 3)
        url.shortened_url
      end
      it 'returns views grouped by date' do
        data = UrlAccess.count_url_views_since(shortened, DateTime.now - 7)

        expect(data.size).to eq(2)

        data.each do |k, _|
          expect {k.try(:to_date)}.not_to raise_error
        end
      end
      it_behaves_like 'a hash with elements' do
        let(:hash) {UrlAccess.count_url_views_since(shortened, DateTime.now - 7)}
      end
    end

    context 'with url but without views' do
      let(:shortened) {create_url.shortened_url}
      it_behaves_like 'an empty hash' do
        let(:hash) {UrlAccess.count_url_views_since(shortened, DateTime.now - 7)}
      end
    end

    context 'without url' do
      it_behaves_like 'an empty hash' do
        let(:hash) {UrlAccess.count_url_views_since('', DateTime.now - 7)}
      end
    end
  end
end
