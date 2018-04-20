# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'railroady/version'

Gem::Specification.new do |spec|
  spec.name          = 'railroady'
  spec.version       = RailRoady::VERSION
  spec.authors       = ['Preston Lee', 'Tobias Crawley', 'Peter Hoeg', 'Javier Smaldone']
  spec.description  = "Ruby on Rails 3/4 model and controller UML class diagram generator. Originally based on the 'railroad' plugin and contributions of many others. (`sudo port install graphviz` before use!)"
  spec.email        = ['preston.lee@prestonlee.com', 'tcrawley@gmail.com', 'peter@hoeg.com', 'p.hoeg@northwind.sg', 'javier@smaldone.com.ar']
  spec.summary      = 'Ruby on Rails 3/4 model and controller UML class diagram generator.'
  spec.homepage      = 'http://github.com/preston/railroady'
  spec.license       = 'GPLv2'

  spec.files         = `git ls-files`.split($INPUT_RECORD_SEPARATOR)
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ['lib']

  spec.add_development_dependency 'bundler'
  spec.add_development_dependency 'rake'
  spec.add_development_dependency 'minitest'
  spec.add_development_dependency 'activesupport'
end
