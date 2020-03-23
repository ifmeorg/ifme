# frozen_string_literal: true

ENV['BUNDLE_GEMFILE'] ||= File.expand_path('../Gemfile', __dir__)

require 'bundler/setup' # Set up gems listed in the Gemfile.

if Gem::Specification.find_all_by_name('dotenv').any?
  require 'dotenv'
  environment = ENV['RAILS_ENV'] || :development
  dotenv_path = File.join('config', 'env', "#{environment}.env")
  Dotenv.load(dotenv_path)
end
