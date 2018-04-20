# -*- encoding: utf-8 -*-
$:.push File.expand_path("../lib", __FILE__)
require "cloudinary/version"

Gem::Specification.new do |s|
  s.name        = "cloudinary"
  s.version     = Cloudinary::VERSION
  s.authors     = ["Nadav Soferman","Itai Lahan","Tal Lev-Ami"]
  s.email       = ["nadav.soferman@cloudinary.com","itai.lahan@cloudinary.com","tal.levami@cloudinary.com"]
  s.homepage    = "http://cloudinary.com"
  s.license     = "MIT"

  s.summary     = %q{Client library for easily using the Cloudinary service}
  s.description = %q{Client library for easily using the Cloudinary service}

  s.rubyforge_project = "cloudinary"

  s.files         = (`git ls-files`.split("\n") - `git ls-files samples`.split("\n")) + Dir.glob("vendor/assets/javascripts/*/*") + Dir.glob("vendor/assets/html/*")
  s.test_files    = `git ls-files -- {test,spec,features}/*`.split("\n")
  s.executables   = `git ls-files -- bin/*`.split("\n").map{ |f| File.basename(f) }
  s.require_paths = ["lib"]

  s.add_dependency "aws_cf_signer"
  s.add_development_dependency "rspec", '>=3.5'
  s.add_development_dependency "rspec-rails"
  s.add_development_dependency "rake"

  if RUBY_VERSION > "2.0"
    s.add_dependency "rest-client"
    s.add_development_dependency "actionpack"
    s.add_development_dependency "simplecov"
    s.add_development_dependency "rubyzip"
  elsif RUBY_VERSION >= "1.9"
    s.add_dependency "rest-client", '< 2.0'
    s.add_dependency 'json', '~> 1.8'
    s.add_development_dependency "actionpack", '< 5.0'
    s.add_development_dependency "simplecov"
    s.add_development_dependency "nokogiri", "<1.7.0"
    s.add_development_dependency "rubyzip", '<1.2.1'
  else
    s.add_dependency "i18n", "<0.7.0"
    s.add_dependency "rest-client", "<=1.6.8"
    s.add_development_dependency "actionpack", "~>3.2.0"
    s.add_development_dependency "nokogiri", "<1.6.0"
  end

end
