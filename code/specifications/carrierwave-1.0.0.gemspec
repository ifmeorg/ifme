# -*- encoding: utf-8 -*-
# stub: carrierwave 1.0.0 ruby lib

Gem::Specification.new do |s|
  s.name = "carrierwave".freeze
  s.version = "1.0.0"

  s.required_rubygems_version = Gem::Requirement.new(">= 0".freeze) if s.respond_to? :required_rubygems_version=
  s.require_paths = ["lib".freeze]
  s.authors = ["Jonas Nicklas".freeze]
  s.date = "2016-12-24"
  s.description = "Upload files in your Ruby applications, map them to a range of ORMs, store them on different backends.".freeze
  s.email = ["jonas.nicklas@gmail.com".freeze]
  s.extra_rdoc_files = ["README.md".freeze]
  s.files = ["README.md".freeze]
  s.homepage = "https://github.com/carrierwaveuploader/carrierwave".freeze
  s.licenses = ["MIT".freeze]
  s.rdoc_options = ["--main".freeze]
  s.required_ruby_version = Gem::Requirement.new(">= 2.0.0".freeze)
  s.rubygems_version = "2.5.2".freeze
  s.summary = "Ruby file upload library".freeze

  s.installed_by_version = "2.5.2" if s.respond_to? :installed_by_version

  if s.respond_to? :specification_version then
    s.specification_version = 4

    if Gem::Version.new(Gem::VERSION) >= Gem::Version.new('1.2.0') then
      s.add_runtime_dependency(%q<activesupport>.freeze, [">= 4.0.0"])
      s.add_runtime_dependency(%q<activemodel>.freeze, [">= 4.0.0"])
      s.add_runtime_dependency(%q<mime-types>.freeze, [">= 1.16"])
      s.add_development_dependency(%q<pg>.freeze, [">= 0"])
      s.add_development_dependency(%q<rails>.freeze, [">= 4.0.0"])
      s.add_development_dependency(%q<cucumber>.freeze, ["~> 2.3.2"])
      s.add_development_dependency(%q<rspec>.freeze, ["~> 3.4.0"])
      s.add_development_dependency(%q<webmock>.freeze, [">= 0"])
      s.add_development_dependency(%q<fog>.freeze, [">= 1.28.0"])
      s.add_development_dependency(%q<mini_magick>.freeze, [">= 3.6.0"])
      s.add_development_dependency(%q<rmagick>.freeze, [">= 0"])
      s.add_development_dependency(%q<nokogiri>.freeze, ["~> 1.6.3"])
      s.add_development_dependency(%q<timecop>.freeze, ["= 0.7.1"])
      s.add_development_dependency(%q<generator_spec>.freeze, [">= 0.9.1"])
      s.add_development_dependency(%q<pry>.freeze, [">= 0"])
    else
      s.add_dependency(%q<activesupport>.freeze, [">= 4.0.0"])
      s.add_dependency(%q<activemodel>.freeze, [">= 4.0.0"])
      s.add_dependency(%q<mime-types>.freeze, [">= 1.16"])
      s.add_dependency(%q<pg>.freeze, [">= 0"])
      s.add_dependency(%q<rails>.freeze, [">= 4.0.0"])
      s.add_dependency(%q<cucumber>.freeze, ["~> 2.3.2"])
      s.add_dependency(%q<rspec>.freeze, ["~> 3.4.0"])
      s.add_dependency(%q<webmock>.freeze, [">= 0"])
      s.add_dependency(%q<fog>.freeze, [">= 1.28.0"])
      s.add_dependency(%q<mini_magick>.freeze, [">= 3.6.0"])
      s.add_dependency(%q<rmagick>.freeze, [">= 0"])
      s.add_dependency(%q<nokogiri>.freeze, ["~> 1.6.3"])
      s.add_dependency(%q<timecop>.freeze, ["= 0.7.1"])
      s.add_dependency(%q<generator_spec>.freeze, [">= 0.9.1"])
      s.add_dependency(%q<pry>.freeze, [">= 0"])
    end
  else
    s.add_dependency(%q<activesupport>.freeze, [">= 4.0.0"])
    s.add_dependency(%q<activemodel>.freeze, [">= 4.0.0"])
    s.add_dependency(%q<mime-types>.freeze, [">= 1.16"])
    s.add_dependency(%q<pg>.freeze, [">= 0"])
    s.add_dependency(%q<rails>.freeze, [">= 4.0.0"])
    s.add_dependency(%q<cucumber>.freeze, ["~> 2.3.2"])
    s.add_dependency(%q<rspec>.freeze, ["~> 3.4.0"])
    s.add_dependency(%q<webmock>.freeze, [">= 0"])
    s.add_dependency(%q<fog>.freeze, [">= 1.28.0"])
    s.add_dependency(%q<mini_magick>.freeze, [">= 3.6.0"])
    s.add_dependency(%q<rmagick>.freeze, [">= 0"])
    s.add_dependency(%q<nokogiri>.freeze, ["~> 1.6.3"])
    s.add_dependency(%q<timecop>.freeze, ["= 0.7.1"])
    s.add_dependency(%q<generator_spec>.freeze, [">= 0.9.1"])
    s.add_dependency(%q<pry>.freeze, [">= 0"])
  end
end
