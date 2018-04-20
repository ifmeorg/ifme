# -*- encoding: utf-8 -*-
# stub: signet 0.5.1 ruby lib
require File.join(File.dirname(__FILE__), 'lib/signet', 'version')

Gem::Specification.new do |s|
  s.name = "signet"
  s.version = Signet::VERSION::STRING

  s.required_rubygems_version = ">= 1.3.5"
  s.require_paths = ["lib"]
  s.authors = ["Bob Aman", "Steven Bazyl"]
  s.license = "Apache-2.0"
  s.description = "Signet is an OAuth 1.0 / OAuth 2.0 implementation.\n"
  s.email = "sbazyl@google.com"
  s.extra_rdoc_files = ["README.md"]
  s.files = %w(signet.gemspec Rakefile LICENSE CHANGELOG.md README.md Gemfile)
  s.files += Dir.glob("lib/**/*.rb")
  s.files += Dir.glob("spec/**/*.{rb,opts}")
  s.files += Dir.glob("vendor/**/*.rb")
  s.files += Dir.glob("tasks/**/*")
  s.files += Dir.glob("website/**/*")
  s.homepage = "https://github.com/google/signet/"
  s.rdoc_options = ["--main", "README.md"]
  s.summary = "Signet is an OAuth 1.0 / OAuth 2.0 implementation."
  s.required_ruby_version = ">= 1.9.3"

  s.add_runtime_dependency 'addressable', '~> 2.3'
  s.add_runtime_dependency 'faraday', '~> 0.9'
  s.add_runtime_dependency 'multi_json', '~> 1.10'
  s.add_runtime_dependency 'jwt', '>= 1.5', '< 3.0'

  s.add_development_dependency 'rake', '~> 10.0'
  s.add_development_dependency 'yard', '~> 0.8'
  s.add_development_dependency 'rspec', '~> 3.1'
  s.add_development_dependency 'launchy', '~> 2.4'
  s.add_development_dependency 'kramdown', '~> 1.5'
  s.add_development_dependency 'simplecov', '~> 0.9'
end
