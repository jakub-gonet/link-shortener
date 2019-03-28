# frozen_string_literal: true

require 'addressable/uri'

class Url < ApplicationRecord
  validates :base_url, presence: true
  validates :shortened_url, presence: true, uniqueness: true

  def error_messages
    errors.full_messages.join('\n')
  end

  class << self
    def domain_forbidden?(domain)
      return true if domain.nil?

      forbidden = Rails.application.config.forbidden_domains
      forbidden.all? do |x|
        !domain.start_with?(x)
      end
    end
  end

end
