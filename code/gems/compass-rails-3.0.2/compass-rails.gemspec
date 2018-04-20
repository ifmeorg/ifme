# -*- encoding: utf-8 -*-
require File.expand_path('../lib/compass-rails/version', __FILE__)

Gem::Specification.new do |gem|
  gem.authors       = ["Scott Davis", "Chris Eppstein", "Craig McNamara"]
  gem.email         = ["jetviper21@gmail.com", "chris@eppsteins.net", "craig.mcnamara@gmail.com"]
  gem.description   = %q{Integrate Compass into Rails 3.0 and up.}
  gem.summary       = %q{Integrate Compass into Rails 3.0 and up.}
  gem.homepage      = "https://github.com/Compass/compass-rails"

  gem.executables   = `git ls-files -- bin/*`.split("\n").map{ |f| File.basename(f) }
  gem.files         = `git ls-files`.split("\n")
  gem.test_files    = `git ls-files -- {test,spec,features}/*`.split("\n")
  gem.name          = "compass-rails"
  gem.require_paths = ["lib"]
  gem.version       = CompassRails::VERSION
  gem.license       = "MIT"

  gem.add_dependency 'compass',    '~> 1.0.0'
  gem.add_dependency 'sprockets',  '< 4.0'
  gem.add_dependency 'sass-rails', '< 5.1'
end
