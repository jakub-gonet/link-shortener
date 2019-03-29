# frozen_string_literal: true

class UrlAccess < ApplicationRecord
  belongs_to :url
  validates :ip, presence: true

  def self.url_views_since(shortened, date)
    UrlAccess.joins(:url)
             .where('shortened_url = :url AND url_accesses.created_at >= :date',
                    url: shortened, date: date)
             .all
  end

  def self.url_views_by_ip(shortened, ip, date)
    url_views_since(shortened, date).where("ip = #{ip}").all
  end
end
