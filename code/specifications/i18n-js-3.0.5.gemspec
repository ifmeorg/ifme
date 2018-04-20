# -*- encoding: utf-8 -*-
# stub: i18n-js 3.0.5 ruby lib

Gem::Specification.new do |s|
  s.name = "i18n-js".freeze
  s.version = "3.0.5"

  s.required_rubygems_version = Gem::Requirement.new(">= 0".freeze) if s.respond_to? :required_rubygems_version=
  s.require_paths = ["lib".freeze]
  s.authors = ["Nando Vieira".freeze]
  s.date = "2018-02-26"
  s.description = "It's a small library to provide the Rails I18n translations on the Javascript.".freeze
  s.email = ["fnando.vieira@gmail.com".freeze]
  s.homepage = "http://rubygems.org/gems/i18n-js".freeze
  s.licenses = ["MIT".freeze]
  s.required_ruby_version = Gem::Requirement.new(">= 2.1.0".freeze)
  s.rubygems_version = "2.5.2".freeze
  s.summary = "It's a small library to provide the Rails I18n translations on the Javascript.".freeze

  s.installed_by_version = "2.5.2" if s.respond_to? :installed_by_version

  if s.respond_to? :specification_version then
    s.specification_version = 4

    if Gem::Version.new(Gem::VERSION) >= Gem::Version.new('1.2.0') then
      s.add_runtime_dependency(%q<i18n>.freeze, ["< 2", ">= 0.6.6"])
      s.add_development_dependency(%q<appraisal>.freeze, ["~> 2.0"])
      s.add_development_dependency(%q<rspec>.freeze, ["~> 3.0"])
      s.add_development_dependency(%q<rake>.freeze, ["~> 12.0"])
      s.add_development_dependency(%q<gem-release>.freeze, [">= 0.7"])
    else
      s.add_dependency(%q<i18n>.freeze, ["< 2", ">= 0.6.6"])
      s.add_dependency(%q<appraisal>.freeze, ["~> 2.0"])
      s.add_dependency(%q<rspec>.freeze, ["~> 3.0"])
      s.add_dependency(%q<rake>.freeze, ["~> 12.0"])
      s.add_dependency(%q<gem-release>.freeze, [">= 0.7"])
    end
  else
    s.add_dependency(%q<i18n>.freeze, ["< 2", ">= 0.6.6"])
    s.add_dependency(%q<appraisal>.freeze, ["~> 2.0"])
    s.add_dependency(%q<rspec>.freeze, ["~> 3.0"])
    s.add_dependency(%q<rake>.freeze, ["~> 12.0"])
    s.add_dependency(%q<gem-release>.freeze, [">= 0.7"])
  end
end
