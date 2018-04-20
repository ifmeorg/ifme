if defined?(SimpleCov)
  SimpleCov.start do
    add_group 'Main', '/lib/'
    add_filter '/spec/'
  end
end

require 'rspec-html-matchers'

Dir[File.expand_path('../../spec/support/**/*.rb', __FILE__)].each { |f| require f }

RSpec.configure do |config|
  config.include RSpecHtmlMatchers

  config.expect_with :rspec do |c|
    c.syntax = :expect
  end

  config.filter_run_excluding :wip => true

  config.extend AssetHelpers
end
