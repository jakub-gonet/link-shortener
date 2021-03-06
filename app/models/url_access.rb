# frozen_string_literal: true

# Represents an access for given {url}[rdoc-ref:Url]
class UrlAccess < ApplicationRecord
  belongs_to :url
  validates :ip, presence: true

  # Finds urls views since given date and counts them by grouping by day for each link
  def self.count_grouped_urls_views_since(date)
    views = UrlAccess.joins(:url)
                     .where('url_accesses.created_at >= :date', date: date)
                     .group('shortened_url, DATE(url_accesses.created_at)')
                     .pluck(:shortened_url, Arel.sql('DATE(url_accesses.created_at), COUNT(*) as c'))
    views.group_by {|view| view[1] }
         .to_h
         .each {|_, v| v.each {|entry| entry.delete_at(1) } }
  end

  # Finds urls views since given date and url and counts them
  def self.count_url_views_since(shortened, date)
    UrlAccess.joins(:url)
             .where('shortened_url = :url AND url_accesses.created_at >= :date',
                    url: shortened, date: date)
             .group('DATE(url_accesses.created_at)')
             .count
  end
end
