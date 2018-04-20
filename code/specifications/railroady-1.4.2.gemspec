# -*- encoding: utf-8 -*-
# stub: railroady 1.4.2 ruby lib

Gem::Specification.new do |s|
  s.name = "railroady".freeze
  s.version = "1.4.2"

  s.required_rubygems_version = Gem::Requirement.new(">= 0".freeze) if s.respond_to? :required_rubygems_version=
  s.require_paths = ["lib".freeze]
  s.authors = ["Preston Lee".freeze, "Tobias Crawley".freeze, "Peter Hoeg".freeze, "Javier Smaldone".freeze]
  s.date = "2015-12-09"
  s.description = "Ruby on Rails 3/4 model and controller UML class diagram generator. Originally based on the 'railroad' plugin and contributions of many others. (`sudo port install graphviz` before use!)".freeze
  s.email = ["preston.lee@prestonlee.com".freeze, "tcrawley@gmail.com".freeze, "peter@hoeg.com".freeze, "p.hoeg@northwind.sg".freeze, "javier@smaldone.com.ar".freeze]
  s.executables = ["railroady".freeze]
  s.files = ["bin/railroady".freeze]
  s.homepage = "http://github.com/preston/railroady".freeze
  s.licenses = ["GPLv2".freeze]
  s.rubygems_version = "2.5.2".freeze
  s.summary = "Ruby on Rails 3/4 model and controller UML class diagram generator.".freeze

  s.installed_by_version = "2.5.2" if s.respond_to? :installed_by_version

  if s.respond_to? :specification_version then
    s.specification_version = 4

    if Gem::Version.new(Gem::VERSION) >= Gem::Version.new('1.2.0') then
      s.add_development_dependency(%q<bundler>.freeze, [">= 0"])
      s.add_development_dependency(%q<rake>.freeze, [">= 0"])
      s.add_development_dependency(%q<minitest>.freeze, [">= 0"])
      s.add_development_dependency(%q<activesupport>.freeze, [">= 0"])
    else
      s.add_dependency(%q<bundler>.freeze, [">= 0"])
      s.add_dependency(%q<rake>.freeze, [">= 0"])
      s.add_dependency(%q<minitest>.freeze, [">= 0"])
      s.add_dependency(%q<activesupport>.freeze, [">= 0"])
    end
  else
    s.add_dependency(%q<bundler>.freeze, [">= 0"])
    s.add_dependency(%q<rake>.freeze, [">= 0"])
    s.add_dependency(%q<minitest>.freeze, [">= 0"])
    s.add_dependency(%q<activesupport>.freeze, [">= 0"])
  end
end
