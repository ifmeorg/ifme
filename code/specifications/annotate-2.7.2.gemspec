# -*- encoding: utf-8 -*-
# stub: annotate 2.7.2 ruby lib

Gem::Specification.new do |s|
  s.name = "annotate".freeze
  s.version = "2.7.2"

  s.required_rubygems_version = Gem::Requirement.new(">= 0".freeze) if s.respond_to? :required_rubygems_version=
  s.require_paths = ["lib".freeze]
  s.authors = ["Alex Chaffee".freeze, "Cuong Tran".freeze, "Marcos Piccinini".freeze, "Turadg Aleahmad".freeze, "Jon Frisby".freeze]
  s.date = "2017-06-02"
  s.description = "Annotates Rails/ActiveRecord Models, routes, fixtures, and others based on the database schema.".freeze
  s.email = ["alex@stinky.com".freeze, "cuong.tran@gmail.com".freeze, "x@nofxx.com".freeze, "turadg@aleahmad.net".freeze, "jon@cloudability.com".freeze]
  s.executables = ["annotate".freeze]
  s.extra_rdoc_files = ["README.rdoc".freeze, "CHANGELOG.rdoc".freeze, "TODO.rdoc".freeze]
  s.files = ["CHANGELOG.rdoc".freeze, "README.rdoc".freeze, "TODO.rdoc".freeze, "bin/annotate".freeze]
  s.homepage = "http://github.com/ctran/annotate_models".freeze
  s.licenses = ["Ruby".freeze]
  s.required_ruby_version = Gem::Requirement.new(">= 1.9.3".freeze)
  s.rubyforge_project = "annotate".freeze
  s.rubygems_version = "2.5.2".freeze
  s.summary = "Annotates Rails Models, routes, fixtures, and others based on the database schema.".freeze

  s.installed_by_version = "2.5.2" if s.respond_to? :installed_by_version

  if s.respond_to? :specification_version then
    s.specification_version = 4

    if Gem::Version.new(Gem::VERSION) >= Gem::Version.new('1.2.0') then
      s.add_runtime_dependency(%q<rake>.freeze, ["< 13.0", ">= 10.4"])
      s.add_runtime_dependency(%q<activerecord>.freeze, ["< 6.0", ">= 3.2"])
    else
      s.add_dependency(%q<rake>.freeze, ["< 13.0", ">= 10.4"])
      s.add_dependency(%q<activerecord>.freeze, ["< 6.0", ">= 3.2"])
    end
  else
    s.add_dependency(%q<rake>.freeze, ["< 13.0", ">= 10.4"])
    s.add_dependency(%q<activerecord>.freeze, ["< 6.0", ">= 3.2"])
  end
end
