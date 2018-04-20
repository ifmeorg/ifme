# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'choice/version'

Gem::Specification.new do |spec|
  spec.name          = "choice"
  spec.version       = Choice::Version::STRING
  spec.authors       = ["Grant Austin", "Chris Wanstrath"]
  spec.email         = ["gaustin@gmail.com", "chris@ozmm.org"]
  spec.summary       = "Choice is a command line option parser."
  spec.description   = "Choice is a simple little gem for easily defining and parsing command line options with a friendly DSL."
  spec.homepage      = "http://www.github.com/defunkt/choice"
  spec.license       = "MIT"

  spec.files         = `git ls-files -z`.split("\x0")
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler", "~> 1.7"
  spec.add_development_dependency "rake", "~> 10.0"
  spec.add_development_dependency "test-unit", "~> 3.0"
end
