# -*- encoding: utf-8 -*-
$:.push File.expand_path("../lib", __FILE__)
require "underscore-rails/version"

Gem::Specification.new do |s|
  s.name        = "underscore-rails"
  s.version     = Underscore::Rails::VERSION
  s.authors     = ["Robin Wenglewski"]
  s.email       = ["robin@wenglewski.de"]
  s.homepage    = "https://github.com/rweng/underscore-rails"
  s.summary     = %q{underscore.js asset pipeline provider/wrapper}
  s.license     = "MIT"

  s.rubyforge_project = "underscore-rails"

  s.files         = `git ls-files`.split("\n")
  s.test_files    = `git ls-files -- {test,spec,features}/*`.split("\n")
  s.executables   = `git ls-files -- bin/*`.split("\n").map{ |f| File.basename(f) }
  s.require_paths = ["lib"]

end
