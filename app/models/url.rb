# frozen_string_literal: true

require 'addressable/uri'

class Url < ApplicationRecord
  has_many :url_access
  validates :base_url, presence: true
  validates :shortened_url, presence: true, uniqueness: true

  before_validation :create_shortened_url
  after_validation :ensure_domain_not_forbidden

  def to_param
    shortened_url
  end

  def error_messages
    errors.full_messages.join('\n')
  end

  private

  def create_shortened_url
    self.shortened_url = ShortenedLinksGenerator.shorten(base_url)
  end

  def ensure_domain_not_forbidden
    domain = Addressable::URI.heuristic_parse(base_url).normalize.domain || ''

    errors.add(:url, 'bad format') if domain.empty?

    forbidden = Rails.application.config.forbidden_domains
    if forbidden.any? { |x| domain.start_with?(x) }
      errors.add(:domain, "#{domain} can't be used to shorten links")
    end
  end
end
