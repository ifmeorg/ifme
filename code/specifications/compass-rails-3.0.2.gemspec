# -*- encoding: utf-8 -*-
# stub: compass-rails 3.0.2 ruby lib

Gem::Specification.new do |s|
  s.name = "compass-rails".freeze
  s.version = "3.0.2"

  s.required_rubygems_version = Gem::Requirement.new(">= 0".freeze) if s.respond_to? :required_rubygems_version=
  s.require_paths = ["lib".freeze]
  s.authors = ["Scott Davis".freeze, "Chris Eppstein".freeze, "Craig McNamara".freeze]
  s.date = "2016-03-03"
  s.description = "Integrate Compass into Rails 3.0 and up.".freeze
  s.email = ["jetviper21@gmail.com".freeze, "chris@eppsteins.net".freeze, "craig.mcnamara@gmail.com".freeze]
  s.homepage = "https://github.com/Compass/compass-rails".freeze
  s.licenses = ["MIT".freeze]
  s.rubygems_version = "2.5.2".freeze
  s.summary = "Integrate Compass into Rails 3.0 and up.".freeze

  s.installed_by_version = "2.5.2" if s.respond_to? :installed_by_version

  if s.respond_to? :specification_version then
    s.specification_version = 4

    if Gem::Version.new(Gem::VERSION) >= Gem::Version.new('1.2.0') then
      s.add_runtime_dependency(%q<compass>.freeze, ["~> 1.0.0"])
      s.add_runtime_dependency(%q<sprockets>.freeze, ["< 4.0"])
      s.add_runtime_dependency(%q<sass-rails>.freeze, ["< 5.1"])
    else
      s.add_dependency(%q<compass>.freeze, ["~> 1.0.0"])
      s.add_dependency(%q<sprockets>.freeze, ["< 4.0"])
      s.add_dependency(%q<sass-rails>.freeze, ["< 5.1"])
    end
  else
    s.add_dependency(%q<compass>.freeze, ["~> 1.0.0"])
    s.add_dependency(%q<sprockets>.freeze, ["< 4.0"])
    s.add_dependency(%q<sass-rails>.freeze, ["< 5.1"])
  end
end
