class Url < ApplicationRecord
  validates :base_url, presence: true
  validates :shortened_url, presence: true

  def error_messages
    errors.full_messages.join('\n')
  end
end
