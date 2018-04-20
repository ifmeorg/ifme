require 'pathname'
test_dir = Pathname.new File.dirname(__FILE__)
$LOAD_PATH.unshift(File.join(File.dirname(__FILE__), '..', 'lib'))
$LOAD_PATH.unshift(File.dirname(__FILE__))

require "fileutils"

ENV["RAILS_ENV"] = "test"

require "bundler"
Bundler.setup

require 'pry' unless RbConfig::CONFIG["RUBY_INSTALL_NAME"] =~ /jruby/

require "active_record"
require "active_record/fixtures"
require "active_support/test_case"

if ActiveSupport::VERSION::STRING < "4.0"
  require 'test/unit'
  require 'mocha/test_unit'
else
  require 'active_support/testing/autorun'
  require "mocha/mini_test"
end

require 'timecop'
require 'chronic'

begin
  require 'composite_primary_keys'
rescue LoadError
  ENV["SKIP_COMPOSITE_PK"] = "true"
end

require "ruby-debug" if RUBY_VERSION.to_f < 1.9

adapter = ENV["ARE_DB"] || "sqlite3"

FileUtils.mkdir_p 'log'
ActiveRecord::Base.logger = Logger.new("log/test.log")
ActiveRecord::Base.logger.level = Logger::DEBUG
ActiveRecord::Base.configurations["test"] = YAML.load_file(test_dir.join("database.yml"))[adapter]
ActiveRecord::Base.default_timezone = :utc

require "activerecord-import"
ActiveRecord::Base.establish_connection :test

ActiveSupport::Notifications.subscribe(/active_record.sql/) do |_, _, _, _, hsh|
  ActiveRecord::Base.logger.info hsh[:sql]
end

require "factory_girl"
Dir[File.dirname(__FILE__) + "/support/**/*.rb"].each { |file| require file }

# Load base/generic schema
require test_dir.join("schema/version")
require test_dir.join("schema/generic_schema")
adapter_schema = test_dir.join("schema/#{adapter}_schema.rb")
require adapter_schema if File.exist?(adapter_schema)

Dir[File.dirname(__FILE__) + "/models/*.rb"].each { |file| require file }

# Prevent this deprecation warning from breaking the tests.
Rake::FileList.send(:remove_method, :import)

ActiveSupport::TestCase.test_order = :random if ENV['AR_VERSION'].to_f >= 4.2
