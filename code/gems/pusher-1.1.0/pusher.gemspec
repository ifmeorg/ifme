# -*- encoding: utf-8 -*-
Gem::Specification.new do |s|
  s.name        = "pusher"
  s.version     = "1.1.0"
  s.platform    = Gem::Platform::RUBY
  s.authors     = ["Pusher"]
  s.email       = ["support@pusher.com"]
  s.homepage    = "http://github.com/pusher/pusher-http-ruby"
  s.summary     = %q{Pusher API client}
  s.description = %q{Wrapper for pusher.com REST api}
  s.license     = "MIT"

  s.add_dependency "multi_json", "~> 1.0"
  s.add_dependency 'pusher-signature', "~> 0.1.8"
  s.add_dependency "httpclient", "~> 2.7"
  s.add_dependency "jruby-openssl" if defined?(JRUBY_VERSION)

  s.add_development_dependency "rspec", "~> 3.0"
  s.add_development_dependency "webmock"
  s.add_development_dependency "em-http-request", "~> 1.1.0"
  s.add_development_dependency "rake"
  s.add_development_dependency "rack"
  s.add_development_dependency "json"

  s.files         = `git ls-files`.split("\n")
  s.test_files    = `git ls-files -- {test,spec,features}/*`.split("\n")
  s.executables   = `git ls-files -- bin/*`.split("\n").map{ |f| File.basename(f) }
  s.require_paths = ["lib"]
end
