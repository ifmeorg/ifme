# frozen_string_literal: true

if ENV["USE_PRY"]
  require "pry"
end

require "minitest/autorun"
require "rails"
require "rails/test_help"
require "webpacker_lite"

Rails.env = "test"

module TestApp
  class Application < ::Rails::Application
    config.root = File.join(File.dirname(__FILE__), "test_app")
  end
end

TestApp::Application.initialize!
