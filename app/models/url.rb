class Url < ApplicationRecord
  validates :base_url, presence: true
  validates :shortened_url, presence: true
end
