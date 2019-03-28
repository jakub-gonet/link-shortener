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
    uri = Addressable::URI.parse(base_url).normalize

    forbidden = Rails.application.config.forbidden_domains
    if forbidden.any? {|x| !uri.domain.start_with?(x)}
      errors.add(:domain, "URL from #{uri.domain} domain can't be shortened")
    end
  end
end
