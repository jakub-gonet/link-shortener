# frozen_string_literal: true

require 'addressable/uri'

# Represents provided url and its shortened version
class Url < ApplicationRecord
  has_many :url_accesses
  validates :base_url, presence: true
  validates :shortened_url, presence: true, uniqueness: true, on: :save
  validate :ensure_domain_not_empty
  validate :ensure_domain_not_forbidden

  before_save :create_shortened_url

  def to_param
    shortened_url
  end

  private

  def create_shortened_url
    self.shortened_url = ShortenedLinksGenerator.shorten(base_url)
  end

  def ensure_domain_not_empty
    errors.add(:url, 'malformed URL') if _url_domain.nil?
  end

  def ensure_domain_not_forbidden
    domain = _url_domain
    forbidden = Rails.application.config.forbidden_domains
    errors.add(:domain, "#{domain} can't be used to shorten links") if forbidden.any? {|x| domain&.start_with?(x) }
  end

  def _url_domain
    Addressable::URI.heuristic_parse(base_url)&.normalize&.domain
  end
end
