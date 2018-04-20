require 'minitest/autorun'
require 'compass-rails'
require 'active_support/all'

module CompassRails
  module Test
    ROOT_PATH = File.expand_path('../../', __FILE__)

    def self.root
      Pathname.new(ROOT_PATH)
    end
  end
end

%w(debug file command rails).each do |helper|
  require File.join(File.expand_path('../', __FILE__), 'helpers', "#{helper}_helper")
end

require File.join(File.expand_path('../', __FILE__), 'helpers', "rails_project")

