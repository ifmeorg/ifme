# frozen_string_literal: true

ENV['RAILS_ENV'] ||= 'test'

require 'simplecov'
SimpleCov.start 'rails'

require File.expand_path('../config/environment', __dir__)
require 'rspec/rails'
require 'rspec/collection_matchers'
require 'capybara/rails'
require 'capybara/rspec'
require 'shoulda/matchers'
require 'database_cleaner'

include Warden::Test::Helpers
Warden.test_mode!

Dir[Rails.root.join('spec/support/**/*.rb')].each { |f| require f }

ActiveRecord::Migration.maintain_test_schema!

if ENV['SELENIUM_REMOTE_HOST']
  Capybara.javascript_driver = :selenium_remote_firefox
  Capybara.register_driver :selenium_remote_firefox do |app|
    options = Selenium::WebDriver::Firefox::Options.new
    options.add_argument('--headless')
    Capybara::Selenium::Driver.new(app, browser: :remote, url: "http://#{ENV['SELENIUM_REMOTE_HOST']}:4444", options: options)
  end

  # This grabs the container's actual internal IP address
  ip = `/sbin/ip route|awk '/scope link src/ {print $9}'`.strip
  
  Capybara.server_host = ip
  Capybara.server_port = 4000
  Capybara.app_host = "http://#{Capybara.server_host}:#{Capybara.server_port}"
else
  Capybara.register_driver :selenium_chrome_headless do |app|
    options = Selenium::WebDriver::Chrome::Options.new
    options.add_argument('--headless')
    options.add_argument('--no-sandbox')
    options.add_argument('--disable-dev-shm-usage')
    options.add_argument('--window-size=1280,800')
    Capybara::Selenium::Driver.new(app, browser: :chrome, options: options)
  end
  Capybara.javascript_driver = :selenium_chrome_headless
end

RSpec.configure do |config|
  ReactOnRails::TestHelper.configure_rspec_to_compile_assets(config, :requires_webpack_assets)

  config.define_derived_metadata(file_path: %r{spec/(features|requests)}) do |metadata|
    metadata[:requires_webpack_assets] = true
  end

  # --- DEVISE HELPERS ---
  config.include Devise::Test::ControllerHelpers, type: :controller
  config.include Devise::Test::ControllerHelpers, type: :helper # Added for your helper specs
  config.include Devise::Test::IntegrationHelpers, type: :request
  # ----------------------

  config.include FactoryBot::Syntax::Methods
  config.include RSpecHtmlMatchers
  config.include StubCurrentUserHelper
  config.include StubOmniauth

  config.mock_with :rspec do |mock_config|
    mock_config.syntax = %i[expect should]
  end

  config.fixture_paths = [Rails.root.join('spec', 'fixtures')]
  config.use_transactional_fixtures = false
  config.infer_base_class_for_anonymous_controllers = false
  config.order = 'random'
  config.infer_spec_type_from_file_location!

  config.before { ActionMailer::Base.deliveries.clear }
  config.filter_run_when_matching :focus

  config.before(header: true) do
    config.include HiddenHeaderSupport
  end

  config.after(:context, type: :feature) do
    Capybara.reset_sessions!
    Capybara.use_default_driver
    Capybara.app_host = nil
  end

  config.after(:each) do
    Warden.test_reset!
  end
end

Shoulda::Matchers.configure do |config|
  config.integrate do |with|
    with.test_framework :rspec
    with.library :rails
  end
end

DatabaseCleaner.allow_remote_database_url = true