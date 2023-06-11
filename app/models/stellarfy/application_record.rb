# Frozen_string_literal: true

module Stellarfy
  class ApplicationRecord < ActiveRecord::Base
    self.abstract_class = true
  end
end
