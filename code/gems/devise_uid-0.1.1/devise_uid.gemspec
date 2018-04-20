# -*- encoding: utf-8 -*-
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'devise_uid/version'

Gem::Specification.new do |gem|
  gem.name          = "devise_uid"
  gem.version       = DeviseUid::VERSION
  gem.authors       = ["Jingwen Owen Ou"]
  gem.email         = ["jingweno@gmail.com"]
  gem.description   = %q{Add UID support to Devise}
  gem.summary       = %q{Add UID support to Devise}
  gem.homepage      = "https://github.com/jingweno/devise_uid"

  gem.files         = `git ls-files`.split($/)
  gem.executables   = gem.files.grep(%r{^bin/}).map{ |f| File.basename(f) }
  gem.test_files    = gem.files.grep(%r{^(test|spec|features)/})
  gem.require_paths = ["lib"]

  gem.add_dependency("devise", ">= 3.0.0")
  gem.add_dependency("railties", ">= 3.0")

  gem.add_development_dependency "rspec", "~> 2.12"
end
