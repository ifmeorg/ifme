# -*- encoding: utf-8 -*-
# stub: rails_serve_static_assets 0.0.5 ruby lib

Gem::Specification.new do |s|
  s.name = "rails_serve_static_assets".freeze
  s.version = "0.0.5"

  s.required_rubygems_version = Gem::Requirement.new(">= 0".freeze) if s.respond_to? :required_rubygems_version=
  s.require_paths = ["lib".freeze]
  s.authors = ["Pedro Belo".freeze, "Jonathan Dance".freeze]
  s.date = "2016-02-01"
  s.description = "Force Rails to serve static assets".freeze
  s.email = ["pedro@heroku.com".freeze, "jd@heroku.com".freeze]
  s.homepage = "https://github.com/heroku/rails_serve_static_assets".freeze
  s.licenses = ["MIT".freeze]
  s.rubygems_version = "2.5.2".freeze
  s.summary = "Sets serve_static_assets to true so Rails will sere your static assets".freeze

  s.installed_by_version = "2.5.2" if s.respond_to? :installed_by_version

  if s.respond_to? :specification_version then
    s.specification_version = 4

    if Gem::Version.new(Gem::VERSION) >= Gem::Version.new('1.2.0') then
      s.add_development_dependency(%q<rails>.freeze, [">= 3.1"])
      s.add_development_dependency(%q<capybara>.freeze, [">= 0"])
      s.add_development_dependency(%q<sprockets>.freeze, [">= 0"])
    else
      s.add_dependency(%q<rails>.freeze, [">= 3.1"])
      s.add_dependency(%q<capybara>.freeze, [">= 0"])
      s.add_dependency(%q<sprockets>.freeze, [">= 0"])
    end
  else
    s.add_dependency(%q<rails>.freeze, [">= 3.1"])
    s.add_dependency(%q<capybara>.freeze, [">= 0"])
    s.add_dependency(%q<sprockets>.freeze, [">= 0"])
  end
end
