# setup rspec matchers
require 'rspec/expectations'
World(RSpec::Matchers)
require 'sinatra/base'
require 'capybara/cucumber'
require 'rspec-html-matchers'

World RSpecHtmlMatchers

$ASSETS_DIR = File.expand_path('../tmp',__FILE__)
$INDEX_HTML = File.join($ASSETS_DIR,'index.html')

class SimpleApp < Sinatra::Base
  set :public_folder, $ASSETS_DIR
end

Capybara.default_driver = :selenium
Capybara.app = SimpleApp

Before do
  FileUtils.mkdir $ASSETS_DIR
end

After do
  FileUtils.rm_rf $ASSETS_DIR
end
