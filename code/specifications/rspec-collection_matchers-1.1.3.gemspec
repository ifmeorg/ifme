# -*- encoding: utf-8 -*-
# stub: rspec-collection_matchers 1.1.3 ruby lib

Gem::Specification.new do |s|
  s.name = "rspec-collection_matchers".freeze
  s.version = "1.1.3"

  s.required_rubygems_version = Gem::Requirement.new(">= 0".freeze) if s.respond_to? :required_rubygems_version=
  s.require_paths = ["lib".freeze]
  s.authors = ["Hugo Bara\u{fa}na".freeze]
  s.date = "2016-12-21"
  s.description = "Collection cardinality matchers, extracted from rspec-expectations".freeze
  s.email = ["hugo.barauna@plataformatec.com.br".freeze]
  s.homepage = "https://github.com/rspec/rspec-collection_matchers".freeze
  s.licenses = ["MIT".freeze]
  s.rubygems_version = "2.5.2".freeze
  s.summary = "rspec-collection_matchers-1.1.3".freeze

  s.installed_by_version = "2.5.2" if s.respond_to? :installed_by_version

  if s.respond_to? :specification_version then
    s.specification_version = 4

    if Gem::Version.new(Gem::VERSION) >= Gem::Version.new('1.2.0') then
      s.add_runtime_dependency(%q<rspec-expectations>.freeze, [">= 2.99.0.beta1"])
      s.add_development_dependency(%q<bundler>.freeze, ["~> 1.3"])
      s.add_development_dependency(%q<activemodel>.freeze, [">= 3.0"])
    else
      s.add_dependency(%q<rspec-expectations>.freeze, [">= 2.99.0.beta1"])
      s.add_dependency(%q<bundler>.freeze, ["~> 1.3"])
      s.add_dependency(%q<activemodel>.freeze, [">= 3.0"])
    end
  else
    s.add_dependency(%q<rspec-expectations>.freeze, [">= 2.99.0.beta1"])
    s.add_dependency(%q<bundler>.freeze, ["~> 1.3"])
    s.add_dependency(%q<activemodel>.freeze, [">= 3.0"])
  end
end
