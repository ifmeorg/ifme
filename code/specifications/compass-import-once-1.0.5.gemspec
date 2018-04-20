# -*- encoding: utf-8 -*-
# stub: compass-import-once 1.0.5 ruby lib

Gem::Specification.new do |s|
  s.name = "compass-import-once".freeze
  s.version = "1.0.5"

  s.required_rubygems_version = Gem::Requirement.new(">= 0".freeze) if s.respond_to? :required_rubygems_version=
  s.require_paths = ["lib".freeze]
  s.authors = ["Chris Eppstein".freeze]
  s.date = "2014-08-04"
  s.description = "Changes the behavior of Sass's @import directive to only import a file once.".freeze
  s.email = ["chris@eppsteins.net".freeze]
  s.homepage = "https://github.com/chriseppstein/compass/tree/master/import-once".freeze
  s.licenses = ["MIT".freeze]
  s.rubygems_version = "2.5.2".freeze
  s.summary = "Speed up your Sass compilation by making @import only import each file once.".freeze

  s.installed_by_version = "2.5.2" if s.respond_to? :installed_by_version

  if s.respond_to? :specification_version then
    s.specification_version = 4

    if Gem::Version.new(Gem::VERSION) >= Gem::Version.new('1.2.0') then
      s.add_runtime_dependency(%q<sass>.freeze, ["< 3.5", ">= 3.2"])
      s.add_development_dependency(%q<bundler>.freeze, ["~> 1.3"])
      s.add_development_dependency(%q<diff-lcs>.freeze, [">= 0"])
      s.add_development_dependency(%q<rake>.freeze, [">= 0"])
      s.add_development_dependency(%q<sass-globbing>.freeze, [">= 0"])
    else
      s.add_dependency(%q<sass>.freeze, ["< 3.5", ">= 3.2"])
      s.add_dependency(%q<bundler>.freeze, ["~> 1.3"])
      s.add_dependency(%q<diff-lcs>.freeze, [">= 0"])
      s.add_dependency(%q<rake>.freeze, [">= 0"])
      s.add_dependency(%q<sass-globbing>.freeze, [">= 0"])
    end
  else
    s.add_dependency(%q<sass>.freeze, ["< 3.5", ">= 3.2"])
    s.add_dependency(%q<bundler>.freeze, ["~> 1.3"])
    s.add_dependency(%q<diff-lcs>.freeze, [">= 0"])
    s.add_dependency(%q<rake>.freeze, [">= 0"])
    s.add_dependency(%q<sass-globbing>.freeze, [">= 0"])
  end
end
