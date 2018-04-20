# frozen_string_literal: true

module Kernel
  # Returns the object's singleton class.
  unless respond_to?(:singleton_class)
    def singleton_class
      class << self
        self
      end
    end
  end # exists in 1.9.2
end
