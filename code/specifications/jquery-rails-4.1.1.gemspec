# -*- encoding: utf-8 -*-
# stub: jquery-rails 4.1.1 ruby lib

Gem::Specification.new do |s|
  s.name = "jquery-rails".freeze
  s.version = "4.1.1"

  s.required_rubygems_version = Gem::Requirement.new(">= 1.3.6".freeze) if s.respond_to? :required_rubygems_version=
  s.require_paths = ["lib".freeze]
  s.authors = ["Andr\u{e9} Arko".freeze]
  s.date = "2016-03-10"
  s.description = "This gem provides jQuery and the jQuery-ujs driver for your Rails 4+ application.".freeze
  s.email = ["andre@arko.net".freeze]
  s.homepage = "http://rubygems.org/gems/jquery-rails".freeze
  s.licenses = ["MIT".freeze]
  s.required_ruby_version = Gem::Requirement.new(">= 1.9.3".freeze)
  s.rubygems_version = "2.5.2".freeze
  s.summary = "Use jQuery with Rails 4+".freeze

  s.installed_by_version = "2.5.2" if s.respond_to? :installed_by_version

  if s.respond_to? :specification_version then
    s.specification_version = 4

    if Gem::Version.new(Gem::VERSION) >= Gem::Version.new('1.2.0') then
      s.add_runtime_dependency(%q<railties>.freeze, [">= 4.2.0"])
      s.add_runtime_dependency(%q<thor>.freeze, ["< 2.0", ">= 0.14"])
      s.add_runtime_dependency(%q<rails-dom-testing>.freeze, ["< 3", ">= 1"])
    else
      s.add_dependency(%q<railties>.freeze, [">= 4.2.0"])
      s.add_dependency(%q<thor>.freeze, ["< 2.0", ">= 0.14"])
      s.add_dependency(%q<rails-dom-testing>.freeze, ["< 3", ">= 1"])
    end
  else
    s.add_dependency(%q<railties>.freeze, [">= 4.2.0"])
    s.add_dependency(%q<thor>.freeze, ["< 2.0", ">= 0.14"])
    s.add_dependency(%q<rails-dom-testing>.freeze, ["< 3", ">= 1"])
  end
end
