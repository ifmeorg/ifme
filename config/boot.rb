# Set up gems listed in the Gemfile.
ENV['BUNDLE_GEMFILE'] ||= File.expand_path('../../Gemfile', __FILE__)

require 'bundler/setup' if File.exist?(ENV['BUNDLE_GEMFILE'])

if Gem::Specification.find_all_by_name('dotenv').any?
  require 'dotenv'

  Dotenv.load "config/env/#{ENV['RAILS_ENV'] || :development}.env"
end
