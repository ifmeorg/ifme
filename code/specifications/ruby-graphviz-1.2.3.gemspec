# -*- encoding: utf-8 -*-
# stub: ruby-graphviz 1.2.3 ruby lib

Gem::Specification.new do |s|
  s.name = "ruby-graphviz".freeze
  s.version = "1.2.3"

  s.required_rubygems_version = Gem::Requirement.new(">= 0".freeze) if s.respond_to? :required_rubygems_version=
  s.require_paths = ["lib".freeze]
  s.authors = ["Gregoire Lejeune".freeze]
  s.date = "2017-03-21"
  s.description = "Ruby/Graphviz provides an interface to layout and generate images of directed graphs in a variety of formats (PostScript, PNG, etc.) using GraphViz.".freeze
  s.email = "gregoire.lejeune@free.fr".freeze
  s.executables = ["dot2ruby".freeze, "gem2gv".freeze, "git2gv".freeze, "ruby2gv".freeze, "xml2gv".freeze]
  s.extra_rdoc_files = ["README.rdoc".freeze, "COPYING.rdoc".freeze, "AUTHORS.rdoc".freeze, "CHANGELOG.rdoc".freeze]
  s.files = ["AUTHORS.rdoc".freeze, "CHANGELOG.rdoc".freeze, "COPYING.rdoc".freeze, "README.rdoc".freeze, "bin/dot2ruby".freeze, "bin/gem2gv".freeze, "bin/git2gv".freeze, "bin/ruby2gv".freeze, "bin/xml2gv".freeze]
  s.homepage = "https://github.com/glejeune/Ruby-Graphviz".freeze
  s.licenses = ["GPL-2.0".freeze]
  s.post_install_message = "\nYou need to install GraphViz (http://graphviz.org/) to use this Gem.\n\nFor more information about Ruby-Graphviz :\n* Doc : http://rdoc.info/projects/glejeune/Ruby-Graphviz\n* Sources : https://github.com/glejeune/Ruby-Graphviz\n* Mailing List : https://groups.google.com/forum/#!forum/ruby-graphviz\n\nLast (important) changes :\nRuby-Graphviz no longer supports Ruby < 1.9.3\n  ".freeze
  s.rdoc_options = ["--title".freeze, "Ruby/GraphViz".freeze, "--main".freeze, "README.rdoc".freeze]
  s.required_ruby_version = Gem::Requirement.new(">= 1.9.3".freeze)
  s.requirements = ["GraphViz".freeze]
  s.rubyforge_project = "ruby-asp".freeze
  s.rubygems_version = "2.5.2".freeze
  s.summary = "Interface to the GraphViz graphing tool".freeze

  s.installed_by_version = "2.5.2" if s.respond_to? :installed_by_version

  if s.respond_to? :specification_version then
    s.specification_version = 4

    if Gem::Version.new(Gem::VERSION) >= Gem::Version.new('1.2.0') then
      s.add_development_dependency(%q<rake>.freeze, [">= 0"])
      s.add_development_dependency(%q<rdoc>.freeze, [">= 0"])
      s.add_development_dependency(%q<bundler>.freeze, [">= 0"])
      s.add_development_dependency(%q<ronn>.freeze, [">= 0"])
      s.add_development_dependency(%q<test-unit>.freeze, [">= 0"])
    else
      s.add_dependency(%q<rake>.freeze, [">= 0"])
      s.add_dependency(%q<rdoc>.freeze, [">= 0"])
      s.add_dependency(%q<bundler>.freeze, [">= 0"])
      s.add_dependency(%q<ronn>.freeze, [">= 0"])
      s.add_dependency(%q<test-unit>.freeze, [">= 0"])
    end
  else
    s.add_dependency(%q<rake>.freeze, [">= 0"])
    s.add_dependency(%q<rdoc>.freeze, [">= 0"])
    s.add_dependency(%q<bundler>.freeze, [">= 0"])
    s.add_dependency(%q<ronn>.freeze, [">= 0"])
    s.add_dependency(%q<test-unit>.freeze, [">= 0"])
  end
end
