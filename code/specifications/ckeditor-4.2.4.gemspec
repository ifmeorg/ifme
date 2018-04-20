# -*- encoding: utf-8 -*-
# stub: ckeditor 4.2.4 ruby lib

Gem::Specification.new do |s|
  s.name = "ckeditor".freeze
  s.version = "4.2.4"

  s.required_rubygems_version = Gem::Requirement.new(">= 0".freeze) if s.respond_to? :required_rubygems_version=
  s.require_paths = ["lib".freeze]
  s.authors = ["Igor Galeta".freeze]
  s.date = "2017-06-29"
  s.description = "CKEditor is a WYSIWYG editor to be used inside web pages".freeze
  s.email = "galeta.igor@gmail.com".freeze
  s.extra_rdoc_files = ["README.md".freeze]
  s.files = ["README.md".freeze]
  s.homepage = "https://github.com/galetahub/ckeditor".freeze
  s.licenses = ["MIT".freeze]
  s.rubyforge_project = "ckeditor".freeze
  s.rubygems_version = "2.5.2".freeze
  s.summary = "Rails gem for easy integration ckeditor in your application".freeze

  s.installed_by_version = "2.5.2" if s.respond_to? :installed_by_version

  if s.respond_to? :specification_version then
    s.specification_version = 4

    if Gem::Version.new(Gem::VERSION) >= Gem::Version.new('1.2.0') then
      s.add_runtime_dependency(%q<cocaine>.freeze, [">= 0"])
      s.add_runtime_dependency(%q<orm_adapter>.freeze, ["~> 0.5.0"])
    else
      s.add_dependency(%q<cocaine>.freeze, [">= 0"])
      s.add_dependency(%q<orm_adapter>.freeze, ["~> 0.5.0"])
    end
  else
    s.add_dependency(%q<cocaine>.freeze, [">= 0"])
    s.add_dependency(%q<orm_adapter>.freeze, ["~> 0.5.0"])
  end
end
