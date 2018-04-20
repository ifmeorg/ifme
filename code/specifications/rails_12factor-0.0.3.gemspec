# -*- encoding: utf-8 -*-
# stub: rails_12factor 0.0.3 ruby lib

Gem::Specification.new do |s|
  s.name = "rails_12factor".freeze
  s.version = "0.0.3"

  s.required_rubygems_version = Gem::Requirement.new(">= 0".freeze) if s.respond_to? :required_rubygems_version=
  s.require_paths = ["lib".freeze]
  s.authors = ["Richard Schneeman".freeze, "Terence Lee".freeze]
  s.date = "2014-10-14"
  s.description = "Run Rails the 12factor way".freeze
  s.email = ["richard@heroku.com".freeze, "terence@heroku.com".freeze]
  s.homepage = "https://github.com/heroku/rails_12factor".freeze
  s.licenses = ["MIT".freeze]
  s.rubygems_version = "2.5.2".freeze
  s.summary = "Following best practices from http://12factor.net run a maintainable, clean, and scalable app on Rails".freeze

  s.installed_by_version = "2.5.2" if s.respond_to? :installed_by_version

  if s.respond_to? :specification_version then
    s.specification_version = 4

    if Gem::Version.new(Gem::VERSION) >= Gem::Version.new('1.2.0') then
      s.add_development_dependency(%q<minitest>.freeze, [">= 0"])
      s.add_development_dependency(%q<rake>.freeze, [">= 0"])
      s.add_runtime_dependency(%q<rails_serve_static_assets>.freeze, [">= 0"])
      s.add_runtime_dependency(%q<rails_stdout_logging>.freeze, [">= 0"])
    else
      s.add_dependency(%q<minitest>.freeze, [">= 0"])
      s.add_dependency(%q<rake>.freeze, [">= 0"])
      s.add_dependency(%q<rails_serve_static_assets>.freeze, [">= 0"])
      s.add_dependency(%q<rails_stdout_logging>.freeze, [">= 0"])
    end
  else
    s.add_dependency(%q<minitest>.freeze, [">= 0"])
    s.add_dependency(%q<rake>.freeze, [">= 0"])
    s.add_dependency(%q<rails_serve_static_assets>.freeze, [">= 0"])
    s.add_dependency(%q<rails_stdout_logging>.freeze, [">= 0"])
  end
end
