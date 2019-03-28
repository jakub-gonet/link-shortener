class UrlAccess < ApplicationRecord
  belongs_to :url
  validates :ip, presence: true
end
