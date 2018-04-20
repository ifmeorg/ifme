# -*- encoding: utf-8 -*-
# stub: chromedriver-helper 1.2.0 ruby lib

Gem::Specification.new do |s|
  s.name = "chromedriver-helper".freeze
  s.version = "1.2.0"

  s.required_rubygems_version = Gem::Requirement.new(">= 0".freeze) if s.respond_to? :required_rubygems_version=
  s.require_paths = ["lib".freeze]
  s.authors = ["Mike Dalessio".freeze]
  s.date = "2018-02-04"
  s.description = "Easy installation and use of chromedriver, the Chromium project's selenium webdriver adapter.".freeze
  s.email = ["mike.dalessio@gmail.com".freeze]
  s.executables = ["chromedriver".freeze, "chromedriver-update".freeze]
  s.files = ["bin/chromedriver".freeze, "bin/chromedriver-update".freeze]
  s.homepage = "https://github.com/flavorjones/chromedriver-helper".freeze
  s.licenses = ["MIT".freeze]
  s.rubygems_version = "2.5.2".freeze
  s.summary = "Easy installation and use of chromedriver.".freeze

  s.installed_by_version = "2.5.2" if s.respond_to? :installed_by_version

  if s.respond_to? :specification_version then
    s.specification_version = 4

    if Gem::Version.new(Gem::VERSION) >= Gem::Version.new('1.2.0') then
      s.add_development_dependency(%q<rspec>.freeze, ["~> 3.0"])
      s.add_development_dependency(%q<rake>.freeze, ["~> 10.0"])
      s.add_development_dependency(%q<concourse>.freeze, ["~> 0.16"])
      s.add_runtime_dependency(%q<nokogiri>.freeze, ["~> 1.8"])
      s.add_runtime_dependency(%q<archive-zip>.freeze, ["~> 0.10"])
    else
      s.add_dependency(%q<rspec>.freeze, ["~> 3.0"])
      s.add_dependency(%q<rake>.freeze, ["~> 10.0"])
      s.add_dependency(%q<concourse>.freeze, ["~> 0.16"])
      s.add_dependency(%q<nokogiri>.freeze, ["~> 1.8"])
      s.add_dependency(%q<archive-zip>.freeze, ["~> 0.10"])
    end
  else
    s.add_dependency(%q<rspec>.freeze, ["~> 3.0"])
    s.add_dependency(%q<rake>.freeze, ["~> 10.0"])
    s.add_dependency(%q<concourse>.freeze, ["~> 0.16"])
    s.add_dependency(%q<nokogiri>.freeze, ["~> 1.8"])
    s.add_dependency(%q<archive-zip>.freeze, ["~> 0.10"])
  end
end
