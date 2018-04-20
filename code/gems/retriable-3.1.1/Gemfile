source "https://rubygems.org"

# Specify your gem's dependencies in retriable.gemspec
gemspec

group :test do
  # gem "ruby_gntp"
  gem "codeclimate-test-reporter", require: false
  gem "minitest-focus"
  gem "simplecov", require: false
end

group :development do
  gem "rubocop"
end

group :development, :test do
  gem "pry"
end
