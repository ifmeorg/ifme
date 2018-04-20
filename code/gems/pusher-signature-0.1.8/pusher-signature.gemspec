# -*- encoding: utf-8 -*-
$:.push File.expand_path("../lib", __FILE__)
require "pusher/signature/version"

Gem::Specification.new do |s|
  s.name        = "pusher-signature"
  s.version     = Pusher::Signature::VERSION
  s.platform    = Gem::Platform::RUBY
  s.authors     = ["Martyn Loughran", "Pusher Ltd"]
  s.email       = ["me@mloughran.com", "support@pusher.com"]
  s.homepage    = "http://github.com/pusher/pusher-signature"
  s.summary     = %q{Simple key/secret based authentication for apis}
  s.description = %q{Simple key/secret based authentication for apis}

  s.files         = `git ls-files`.split("\n")
  s.test_files    = `git ls-files -- {test,spec,features}/*`.split("\n")
  s.executables   = `git ls-files -- bin/*`.split("\n").map{ |f| File.basename(f) }
  s.require_paths = ["lib"]
  s.license = 'MIT'

  s.add_dependency "jruby-openssl" if defined?(JRUBY_VERSION)
  s.add_development_dependency "rspec", "= 2.13.0"
  s.add_development_dependency "em-spec", "= 0.2.6"
end
