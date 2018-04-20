# -*- encoding: utf-8 -*-
# stub: rack-rewrite 1.5.1 ruby lib

Gem::Specification.new do |s|
  s.name = "rack-rewrite".freeze
  s.version = "1.5.1"

  s.required_rubygems_version = Gem::Requirement.new(">= 0".freeze) if s.respond_to? :required_rubygems_version=
  s.require_paths = ["lib".freeze]
  s.authors = ["Travis Jeffery".freeze, "John Trupiano".freeze]
  s.date = "2014-12-31"
  s.description = "A rack middleware for enforcing rewrite rules. In many cases you can get away with rack-rewrite instead of writing Apache mod_rewrite rules.".freeze
  s.email = "travisjeffery@gmail.com".freeze
  s.extra_rdoc_files = ["LICENSE".freeze, "History.rdoc".freeze]
  s.files = ["History.rdoc".freeze, "LICENSE".freeze]
  s.homepage = "http://github.com/jtrupiano/rack-rewrite".freeze
  s.rdoc_options = ["--charset=UTF-8".freeze]
  s.rubyforge_project = "johntrupiano".freeze
  s.rubygems_version = "2.5.2".freeze
  s.summary = "A rack middleware for enforcing rewrite rules".freeze

  s.installed_by_version = "2.5.2" if s.respond_to? :installed_by_version

  if s.respond_to? :specification_version then
    s.specification_version = 3

    if Gem::Version.new(Gem::VERSION) >= Gem::Version.new('1.2.0') then
      s.add_development_dependency(%q<bundler>.freeze, [">= 0"])
      s.add_development_dependency(%q<shoulda>.freeze, ["~> 2.10.2"])
      s.add_development_dependency(%q<mocha>.freeze, ["~> 0.9.7"])
      s.add_development_dependency(%q<rack>.freeze, [">= 0"])
    else
      s.add_dependency(%q<bundler>.freeze, [">= 0"])
      s.add_dependency(%q<shoulda>.freeze, ["~> 2.10.2"])
      s.add_dependency(%q<mocha>.freeze, ["~> 0.9.7"])
      s.add_dependency(%q<rack>.freeze, [">= 0"])
    end
  else
    s.add_dependency(%q<bundler>.freeze, [">= 0"])
    s.add_dependency(%q<shoulda>.freeze, ["~> 2.10.2"])
    s.add_dependency(%q<mocha>.freeze, ["~> 0.9.7"])
    s.add_dependency(%q<rack>.freeze, [">= 0"])
  end
end
