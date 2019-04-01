# frozen_string_literal: true

class UrlAccess < ApplicationRecord
  belongs_to :url
  validates :ip, presence: true

  def self.count_all_urls_views_since(date)
    UrlAccess.joins(:url)
             .where('url_accesses.created_at >= :date', date: date)
             .group('shortened_url, DATE(url_accesses.created_at)')
             .pluck('shortened_url, DATE(url_accesses.created_at), COUNT(*) as c')
  end

  def self.count_url_views_since(shortened, date)
    UrlAccess.joins(:url)
             .where('shortened_url = :url AND url_accesses.created_at >= :date',
                    url: shortened, date: date)
             .group('DATE(url_accesses.created_at)')
             .count
  end
end
