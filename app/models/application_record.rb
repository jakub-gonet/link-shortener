# frozen_string_literal: true

# An abstract model from which inherits every other
class ApplicationRecord < ActiveRecord::Base
  self.abstract_class = true
end
