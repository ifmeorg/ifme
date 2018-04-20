# -*- encoding: utf-8 -*-
# stub: jshint 1.5.0 ruby lib

Gem::Specification.new do |s|
  s.name = "jshint".freeze
  s.version = "1.5.0"

  s.required_rubygems_version = Gem::Requirement.new(">= 0".freeze) if s.respond_to? :required_rubygems_version=
  s.require_paths = ["lib".freeze]
  s.authors = ["Damian Nicholson".freeze]
  s.date = "2016-11-07"
  s.description = "It achieves this by linting your code through a library called JSHint which catches most code smells, and ensures code consistency".freeze
  s.email = ["damian.nicholson21@gmail.com".freeze]
  s.executables = ["jshint".freeze]
  s.files = ["bin/jshint".freeze]
  s.homepage = "http://damiannicholson.com".freeze
  s.licenses = ["MIT".freeze]
  s.rubygems_version = "2.5.2".freeze
  s.summary = "Ensures your JavaScript code adheres to best practices".freeze

  s.installed_by_version = "2.5.2" if s.respond_to? :installed_by_version

  if s.respond_to? :specification_version then
    s.specification_version = 4

    if Gem::Version.new(Gem::VERSION) >= Gem::Version.new('1.2.0') then
      s.add_runtime_dependency(%q<therubyracer>.freeze, ["~> 0.12.1"])
      s.add_runtime_dependency(%q<execjs>.freeze, [">= 1.4.0"])
      s.add_runtime_dependency(%q<multi_json>.freeze, ["~> 1.0"])
      s.add_development_dependency(%q<bundler>.freeze, ["~> 1.3"])
      s.add_development_dependency(%q<railties>.freeze, ["< 5.0.0", ">= 3.2.0"])
      s.add_development_dependency(%q<rake>.freeze, [">= 0"])
      s.add_development_dependency(%q<rspec>.freeze, ["~> 3.1.0"])
      s.add_development_dependency(%q<yard>.freeze, [">= 0"])
      s.add_development_dependency(%q<tins>.freeze, ["~> 1.6.0"])
      s.add_development_dependency(%q<term-ansicolor>.freeze, ["~> 1.3.0"])
      s.add_development_dependency(%q<json>.freeze, ["~> 1.8.3"])
    else
      s.add_dependency(%q<therubyracer>.freeze, ["~> 0.12.1"])
      s.add_dependency(%q<execjs>.freeze, [">= 1.4.0"])
      s.add_dependency(%q<multi_json>.freeze, ["~> 1.0"])
      s.add_dependency(%q<bundler>.freeze, ["~> 1.3"])
      s.add_dependency(%q<railties>.freeze, ["< 5.0.0", ">= 3.2.0"])
      s.add_dependency(%q<rake>.freeze, [">= 0"])
      s.add_dependency(%q<rspec>.freeze, ["~> 3.1.0"])
      s.add_dependency(%q<yard>.freeze, [">= 0"])
      s.add_dependency(%q<tins>.freeze, ["~> 1.6.0"])
      s.add_dependency(%q<term-ansicolor>.freeze, ["~> 1.3.0"])
      s.add_dependency(%q<json>.freeze, ["~> 1.8.3"])
    end
  else
    s.add_dependency(%q<therubyracer>.freeze, ["~> 0.12.1"])
    s.add_dependency(%q<execjs>.freeze, [">= 1.4.0"])
    s.add_dependency(%q<multi_json>.freeze, ["~> 1.0"])
    s.add_dependency(%q<bundler>.freeze, ["~> 1.3"])
    s.add_dependency(%q<railties>.freeze, ["< 5.0.0", ">= 3.2.0"])
    s.add_dependency(%q<rake>.freeze, [">= 0"])
    s.add_dependency(%q<rspec>.freeze, ["~> 3.1.0"])
    s.add_dependency(%q<yard>.freeze, [">= 0"])
    s.add_dependency(%q<tins>.freeze, ["~> 1.6.0"])
    s.add_dependency(%q<term-ansicolor>.freeze, ["~> 1.3.0"])
    s.add_dependency(%q<json>.freeze, ["~> 1.8.3"])
  end
end
