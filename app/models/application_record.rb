# frozen_string_literal: true

# Public: Abstract class
class ApplicationRecord < ActiveRecord::Base
  self.abstract_class = true
end
