# frozen_string_literal: true

source 'https://rubygems.org'
ruby '~> 3.1.4'

gem 'puma', '5.6.8'  # Latest capybara doesn't work with puma 6.0 at the moment.
gem 'rack-rewrite'
gem 'rails', '~> 7.0.8'

gem 'activerecord-import'
gem 'bcrypt', '3.1.13'
gem 'devise', '~> 4.8.1'
gem 'devise_invitable', '~> 2.0.9'
gem 'devise-pwned_password'
gem 'devise_uid'
gem 'pg', '1.1.4'
gem "recaptcha"
gem 'resque', '2.6.0'
gem 'resque-scheduler', '4.10.2'
gem 'resque_mailer', '2.4.3'

gem 'jbuilder', '~> 2.9.1'
gem 'jquery-rails', '4.4.0'
gem 'sass-rails', '~> 5.0', '>= 5.0.6'
gem 'turbolinks', '~> 5.2.0'

gem 'carrierwave', '~> 2.2.5'
gem 'certified', '1.0.0'
gem 'chronic', '0.10.2'
gem 'cloudinary', '~> 1.25.0'
gem 'google-api-client', '~> 0.53.0'
gem 'kaminari', '1.2.1'
gem 'omniauth', '~> 2.0'
gem 'omniauth-facebook'
gem 'omniauth-google-oauth2', '~> 1.0.1'
gem 'omniauth-rails_csrf_protection', '~> 1.0.1'
gem 'premailer-rails'
gem 'pusher', '1.3.3'
gem 'rails-i18n', '~> 7.0.5'

gem 'friendly_id', '~> 5.2.5'
gem 'sdoc', '1.0.0', group: :doc

gem 'font-awesome-sass'
gem 'inline_svg'

gem 'groupdate', '~> 6.1'

gem 'react_on_rails', '12.0.1'
gem 'webpacker'

gem 'selenium-webdriver', '~> 4.11.0'

gem 'rubyzip', '~> 1.3.0'

gem 'sidekiq', '6.5.10'
gem 'sidekiq-middleware'
gem 'sidekiq-failures'
gem "sidekiq-cron", "~> 1.1"
gem 'net-smtp', require: false # this is a rails 6 fix and will go away soon.
gem "sprockets-rails"

group :development, :test do
  gem 'bundler-audit'
  gem 'dotenv-rails', '~> 2.7.2'

  gem 'spring'

  gem 'annotate', '~> 3.2.0'
  gem 'railroady', '1.5.3'
  gem 'rails-erd', '~> 1.6'

  gem 'better_errors', '~> 2.5'
  gem 'byebug'
  gem 'pry-byebug'
  gem 'pry-rails'
  gem 'rack-mini-profiler'

  gem 'capybara', '~> 3.39.2'
  gem 'factory_bot_rails'
  gem 'rspec-collection_matchers', '~> 1.1.3'
  gem 'rspec-html-matchers', '~> 0.9.0'
  gem 'rspec-rails', '~> 4.0.0'

  gem 'letter_opener'
  gem 'rspec_junit_formatter'

  gem 'rubocop'
  gem 'rubocop-performance'
  gem 'rubocop-rails'
  gem 'rubocop-rspec'

  gem 'foreman'

  gem 'bullet'

  gem 'actionview'
end

group :test do
  gem 'database_cleaner'
  gem 'rails-controller-testing'
  gem 'shoulda-matchers', '~> 5.3.0'
  gem 'simplecov', '~> 0.17.0'
end

group :production do
  gem 'rack-timeout'
  gem 'rails_12factor', '0.0.3'
  gem 'sentry-ruby'
end

gem "terser", "~> 1.1"
