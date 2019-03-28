# frozen_string_literal: true

require 'addressable/uri'

class Url < ApplicationRecord
  validates :base_url, presence: true
  validates :shortened_url, presence: true, uniqueness: true

  after_validation :ensure_domain_not_forbidden

  def error_messages
    errors.full_messages.join('\n')
  end

  private

  def ensure_domain_not_forbidden
    domain = Addressable::URI.heuristic_parse(base_url).normalize.domain || ''

    errors.add(:url, 'Bad URL format') if domain.empty?

    forbidden = Rails.application.config.forbidden_domains
    if forbidden.any? { |x| domain.start_with?(x) }
      errors.add(:domain, "URL from #{domain} domain can't be shortened")
    end
  end
end
