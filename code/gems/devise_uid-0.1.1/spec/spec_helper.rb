$:.unshift File.expand_path("..", __FILE__)
$:.unshift File.expand_path("../../lib", __FILE__)

require "rspec"
require "devise_uid"
require "devise/orm/active_record"
require "active_record"

ActiveRecord::Migration.verbose = false
ActiveRecord::Base.logger = Logger.new(nil)
ActiveRecord::Base.establish_connection(
  :adapter  => "sqlite3",
  :database => ":memory:",
  :pool => 5)
ActiveRecord::Migrator.migrate(File.expand_path("../db/migrate/", __FILE__))

RSpec.configure do |config|
end
