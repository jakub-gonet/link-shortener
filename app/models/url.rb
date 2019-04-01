# frozen_string_literal: true

require 'addressable/uri'

class Url < ApplicationRecord
  has_many :url_accesses
  validates :base_url, presence: true
  validates :shortened_url, presence: true, uniqueness: true
  validate :ensure_domain_not_empty
  validate :ensure_domain_not_forbidden

  before_validation :create_shortened_url

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

  def ensure_domain_not_empty
    errors.add(:url, 'bad format') if _url_domain.nil?
  end

  def ensure_domain_not_forbidden
    domain = _url_domain
    forbidden = Rails.application.config.forbidden_domains
    if forbidden.any? { |x| domain&.start_with?(x) }
      errors.add(:domain, "#{domain} can't be used to shorten links")
    end
  end

  def _url_domain
    Addressable::URI.heuristic_parse(base_url)&.normalize&.domain
  end
end
