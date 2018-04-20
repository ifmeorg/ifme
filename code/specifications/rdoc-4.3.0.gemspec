# -*- encoding: utf-8 -*-
# stub: rdoc 4.3.0 ruby lib

Gem::Specification.new do |s|
  s.name = "rdoc".freeze
  s.version = "4.3.0"

  s.required_rubygems_version = Gem::Requirement.new(">= 1.3".freeze) if s.respond_to? :required_rubygems_version=
  s.require_paths = ["lib".freeze]
  s.authors = ["Eric Hodel".freeze, "Dave Thomas".freeze, "Phil Hagelberg".freeze, "Tony Strauss".freeze]
  s.date = "2016-11-05"
  s.description = "RDoc produces HTML and command-line documentation for Ruby projects.  RDoc\nincludes the +rdoc+ and +ri+ tools for generating and displaying documentation\nfrom the command-line.".freeze
  s.email = ["drbrain@segment7.net".freeze, "".freeze, "technomancy@gmail.com".freeze, "tony.strauss@designingpatterns.com".freeze]
  s.executables = ["rdoc".freeze, "ri".freeze]
  s.extra_rdoc_files = ["CONTRIBUTING.rdoc".freeze, "CVE-2013-0256.rdoc".freeze, "ExampleMarkdown.md".freeze, "ExampleRDoc.rdoc".freeze, "History.rdoc".freeze, "LEGAL.rdoc".freeze, "LICENSE.rdoc".freeze, "Manifest.txt".freeze, "README.rdoc".freeze, "RI.rdoc".freeze, "TODO.rdoc".freeze, "Rakefile".freeze]
  s.files = ["CONTRIBUTING.rdoc".freeze, "CVE-2013-0256.rdoc".freeze, "ExampleMarkdown.md".freeze, "ExampleRDoc.rdoc".freeze, "History.rdoc".freeze, "LEGAL.rdoc".freeze, "LICENSE.rdoc".freeze, "Manifest.txt".freeze, "README.rdoc".freeze, "RI.rdoc".freeze, "Rakefile".freeze, "TODO.rdoc".freeze, "bin/rdoc".freeze, "bin/ri".freeze]
  s.homepage = "http://docs.seattlerb.org/rdoc".freeze
  s.licenses = ["Ruby".freeze]
  s.rdoc_options = ["--main".freeze, "README.rdoc".freeze]
  s.required_ruby_version = Gem::Requirement.new(">= 1.9.3".freeze)
  s.rubygems_version = "2.5.2".freeze
  s.summary = "RDoc produces HTML and command-line documentation for Ruby projects".freeze

  s.installed_by_version = "2.5.2" if s.respond_to? :installed_by_version

  if s.respond_to? :specification_version then
    s.specification_version = 4

    if Gem::Version.new(Gem::VERSION) >= Gem::Version.new('1.2.0') then
      s.add_development_dependency(%q<kpeg>.freeze, ["~> 0.9"])
      s.add_development_dependency(%q<minitest>.freeze, ["~> 5.9"])
      s.add_development_dependency(%q<racc>.freeze, ["> 1.4.10", "~> 1.4"])
      s.add_development_dependency(%q<rdoc>.freeze, ["~> 4.0"])
      s.add_development_dependency(%q<hoe>.freeze, ["~> 3.15"])
    else
      s.add_dependency(%q<kpeg>.freeze, ["~> 0.9"])
      s.add_dependency(%q<minitest>.freeze, ["~> 5.9"])
      s.add_dependency(%q<racc>.freeze, ["> 1.4.10", "~> 1.4"])
      s.add_dependency(%q<rdoc>.freeze, ["~> 4.0"])
      s.add_dependency(%q<hoe>.freeze, ["~> 3.15"])
    end
  else
    s.add_dependency(%q<kpeg>.freeze, ["~> 0.9"])
    s.add_dependency(%q<minitest>.freeze, ["~> 5.9"])
    s.add_dependency(%q<racc>.freeze, ["> 1.4.10", "~> 1.4"])
    s.add_dependency(%q<rdoc>.freeze, ["~> 4.0"])
    s.add_dependency(%q<hoe>.freeze, ["~> 3.15"])
  end
end
