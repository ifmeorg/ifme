# -*- encoding: utf-8 -*-
# stub: vegas 0.1.11 ruby lib

Gem::Specification.new do |s|
  s.name = "vegas".freeze
  s.version = "0.1.11"

  s.required_rubygems_version = Gem::Requirement.new(">= 0".freeze) if s.respond_to? :required_rubygems_version=
  s.require_paths = ["lib".freeze]
  s.authors = ["Aaron Quint".freeze]
  s.date = "2009-08-30"
  s.description = "Vegas aims to solve the simple problem of creating executable versions of Sinatra/Rack apps. It includes a class Vegas::Runner that wraps Rack/Sinatra applications and provides a simple command line interface and launching mechanism.".freeze
  s.email = ["aaron@quirkey.com".freeze]
  s.extra_rdoc_files = ["LICENSE".freeze, "README.rdoc".freeze]
  s.files = ["LICENSE".freeze, "README.rdoc".freeze]
  s.homepage = "http://code.quirkey.com/vegas".freeze
  s.rubyforge_project = "quirkey".freeze
  s.rubygems_version = "2.5.2".freeze
  s.summary = "Vegas aims to solve the simple problem of creating executable versions of Sinatra/Rack apps.".freeze

  s.installed_by_version = "2.5.2" if s.respond_to? :installed_by_version

  if s.respond_to? :specification_version then
    s.specification_version = 3

    if Gem::Version.new(Gem::VERSION) >= Gem::Version.new('1.2.0') then
      s.add_runtime_dependency(%q<rack>.freeze, [">= 1.0.0"])
      s.add_development_dependency(%q<mocha>.freeze, ["~> 0.9.8"])
      s.add_development_dependency(%q<bacon>.freeze, ["~> 1.1.0"])
      s.add_development_dependency(%q<sinatra>.freeze, ["~> 0.9.4"])
    else
      s.add_dependency(%q<rack>.freeze, [">= 1.0.0"])
      s.add_dependency(%q<mocha>.freeze, ["~> 0.9.8"])
      s.add_dependency(%q<bacon>.freeze, ["~> 1.1.0"])
      s.add_dependency(%q<sinatra>.freeze, ["~> 0.9.4"])
    end
  else
    s.add_dependency(%q<rack>.freeze, [">= 1.0.0"])
    s.add_dependency(%q<mocha>.freeze, ["~> 0.9.8"])
    s.add_dependency(%q<bacon>.freeze, ["~> 1.1.0"])
    s.add_dependency(%q<sinatra>.freeze, ["~> 0.9.4"])
  end
end
