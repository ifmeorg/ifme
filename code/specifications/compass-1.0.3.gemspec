# -*- encoding: utf-8 -*-
# stub: compass 1.0.3 ruby lib

Gem::Specification.new do |s|
  s.name = "compass".freeze
  s.version = "1.0.3"

  s.required_rubygems_version = Gem::Requirement.new(">= 0".freeze) if s.respond_to? :required_rubygems_version=
  s.require_paths = ["lib".freeze]
  s.authors = ["Chris Eppstein".freeze, "Scott Davis".freeze, "Eric M. Suzanne".freeze, "Brandon Mathis".freeze, "Nico Hagenburger".freeze]
  s.date = "2015-01-15"
  s.description = "Compass is a Sass-based Stylesheet Framework that streamlines the creation and maintenance of CSS.".freeze
  s.email = "chris@eppsteins.net".freeze
  s.executables = ["compass".freeze]
  s.files = ["bin/compass".freeze]
  s.homepage = "http://compass-style.org".freeze
  s.post_install_message = "    Compass is charityware. If you love it, please donate on our behalf at http://umdf.org/compass Thanks!\n".freeze
  s.rubygems_version = "2.5.2".freeze
  s.summary = "A Real Stylesheet Framework".freeze

  s.installed_by_version = "2.5.2" if s.respond_to? :installed_by_version

  if s.respond_to? :specification_version then
    s.specification_version = 4

    if Gem::Version.new(Gem::VERSION) >= Gem::Version.new('1.2.0') then
      s.add_runtime_dependency(%q<sass>.freeze, ["< 3.5", ">= 3.3.13"])
      s.add_runtime_dependency(%q<compass-core>.freeze, ["~> 1.0.2"])
      s.add_runtime_dependency(%q<compass-import-once>.freeze, ["~> 1.0.5"])
      s.add_runtime_dependency(%q<chunky_png>.freeze, ["~> 1.2"])
      s.add_runtime_dependency(%q<rb-fsevent>.freeze, [">= 0.9.3"])
      s.add_runtime_dependency(%q<rb-inotify>.freeze, [">= 0.9"])
    else
      s.add_dependency(%q<sass>.freeze, ["< 3.5", ">= 3.3.13"])
      s.add_dependency(%q<compass-core>.freeze, ["~> 1.0.2"])
      s.add_dependency(%q<compass-import-once>.freeze, ["~> 1.0.5"])
      s.add_dependency(%q<chunky_png>.freeze, ["~> 1.2"])
      s.add_dependency(%q<rb-fsevent>.freeze, [">= 0.9.3"])
      s.add_dependency(%q<rb-inotify>.freeze, [">= 0.9"])
    end
  else
    s.add_dependency(%q<sass>.freeze, ["< 3.5", ">= 3.3.13"])
    s.add_dependency(%q<compass-core>.freeze, ["~> 1.0.2"])
    s.add_dependency(%q<compass-import-once>.freeze, ["~> 1.0.5"])
    s.add_dependency(%q<chunky_png>.freeze, ["~> 1.2"])
    s.add_dependency(%q<rb-fsevent>.freeze, [">= 0.9.3"])
    s.add_dependency(%q<rb-inotify>.freeze, [">= 0.9"])
  end
end
