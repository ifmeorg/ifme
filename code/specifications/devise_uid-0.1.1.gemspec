# -*- encoding: utf-8 -*-
# stub: devise_uid 0.1.1 ruby lib

Gem::Specification.new do |s|
  s.name = "devise_uid".freeze
  s.version = "0.1.1"

  s.required_rubygems_version = Gem::Requirement.new(">= 0".freeze) if s.respond_to? :required_rubygems_version=
  s.require_paths = ["lib".freeze]
  s.authors = ["Jingwen Owen Ou".freeze]
  s.date = "2014-08-12"
  s.description = "Add UID support to Devise".freeze
  s.email = ["jingweno@gmail.com".freeze]
  s.homepage = "https://github.com/jingweno/devise_uid".freeze
  s.rubygems_version = "2.5.2".freeze
  s.summary = "Add UID support to Devise".freeze

  s.installed_by_version = "2.5.2" if s.respond_to? :installed_by_version

  if s.respond_to? :specification_version then
    s.specification_version = 4

    if Gem::Version.new(Gem::VERSION) >= Gem::Version.new('1.2.0') then
      s.add_runtime_dependency(%q<devise>.freeze, [">= 3.0.0"])
      s.add_runtime_dependency(%q<railties>.freeze, [">= 3.0"])
      s.add_development_dependency(%q<rspec>.freeze, ["~> 2.12"])
    else
      s.add_dependency(%q<devise>.freeze, [">= 3.0.0"])
      s.add_dependency(%q<railties>.freeze, [">= 3.0"])
      s.add_dependency(%q<rspec>.freeze, ["~> 2.12"])
    end
  else
    s.add_dependency(%q<devise>.freeze, [">= 3.0.0"])
    s.add_dependency(%q<railties>.freeze, [">= 3.0"])
    s.add_dependency(%q<rspec>.freeze, ["~> 2.12"])
  end
end
