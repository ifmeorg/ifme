require 'turbolinks/source/version'

module Turbolinks
  module Source
    def self.asset_path
      File.expand_path("../../assets/javascripts", __FILE__)
    end
  end
end
