# -*- encoding: utf-8 -*-
# stub: rails-erd 1.5.2 ruby lib

Gem::Specification.new do |s|
  s.name = "rails-erd".freeze
  s.version = "1.5.2"

  s.required_rubygems_version = Gem::Requirement.new(">= 0".freeze) if s.respond_to? :required_rubygems_version=
  s.require_paths = ["lib".freeze]
  s.authors = ["Rolf Timmermans".freeze, "Kerri Miller".freeze]
  s.date = "2017-05-24"
  s.description = "Automatically generate an entity-relationship diagram (ERD) for your Rails models.".freeze
  s.email = ["r.timmermans@voormedia.com".freeze, "kerrizor@kerrizor.com".freeze]
  s.executables = ["erd".freeze]
  s.files = ["bin/erd".freeze]
  s.homepage = "https://github.com/voormedia/rails-erd".freeze
  s.licenses = ["MIT".freeze]
  s.required_ruby_version = Gem::Requirement.new(">= 1.9.3".freeze)
  s.rubygems_version = "2.5.2".freeze
  s.summary = "Entity-relationship diagram for your Rails models.".freeze

  s.installed_by_version = "2.5.2" if s.respond_to? :installed_by_version

  if s.respond_to? :specification_version then
    s.specification_version = 4

    if Gem::Version.new(Gem::VERSION) >= Gem::Version.new('1.2.0') then
      s.add_runtime_dependency(%q<activerecord>.freeze, [">= 3.2"])
      s.add_runtime_dependency(%q<activesupport>.freeze, [">= 3.2"])
      s.add_runtime_dependency(%q<ruby-graphviz>.freeze, ["~> 1.2"])
      s.add_runtime_dependency(%q<choice>.freeze, ["~> 0.2.0"])
    else
      s.add_dependency(%q<activerecord>.freeze, [">= 3.2"])
      s.add_dependency(%q<activesupport>.freeze, [">= 3.2"])
      s.add_dependency(%q<ruby-graphviz>.freeze, ["~> 1.2"])
      s.add_dependency(%q<choice>.freeze, ["~> 0.2.0"])
    end
  else
    s.add_dependency(%q<activerecord>.freeze, [">= 3.2"])
    s.add_dependency(%q<activesupport>.freeze, [">= 3.2"])
    s.add_dependency(%q<ruby-graphviz>.freeze, ["~> 1.2"])
    s.add_dependency(%q<choice>.freeze, ["~> 0.2.0"])
  end
end
