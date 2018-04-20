# -*- encoding: utf-8 -*-
$:.push File.expand_path("../lib", __FILE__)

require "graphviz/constants"

Gem::Specification.new do |s|
  s.name = "ruby-graphviz"
  s.version = GraphViz::Constants::RGV_VERSION
  s.platform = Gem::Platform::RUBY
  s.license = "GPL-2.0"

  s.authors = ["Gregoire Lejeune"]
  s.summary = "Interface to the GraphViz graphing tool"
  s.email = "gregoire.lejeune@free.fr"
  s.homepage = "https://github.com/glejeune/Ruby-Graphviz"
  s.description = "Ruby/Graphviz provides an interface to layout and generate images of directed graphs in a variety of formats (PostScript, PNG, etc.) using GraphViz."

  s.files         = `git ls-files`.split("\n")
  s.test_files    = `git ls-files -- {test,spec,features}/*`.split("\n")
  s.executables   = `git ls-files -- bin/*`.split("\n").map{ |f| File.basename(f) }
  s.require_paths = ["lib"]

  s.rubyforge_project = 'ruby-asp'
  s.has_rdoc = true
  s.extra_rdoc_files = ["README.rdoc", "COPYING.rdoc", "AUTHORS.rdoc", "CHANGELOG.rdoc"]
  s.rdoc_options = ["--title", "Ruby/GraphViz", "--main", "README.rdoc"]
  s.post_install_message = %{
You need to install GraphViz (http://graphviz.org/) to use this Gem.

For more information about Ruby-Graphviz :
* Doc : http://rdoc.info/projects/glejeune/Ruby-Graphviz
* Sources : https://github.com/glejeune/Ruby-Graphviz
* Mailing List : https://groups.google.com/forum/#!forum/ruby-graphviz

Last (important) changes :
Ruby-Graphviz no longer supports Ruby < 1.9.3
  }

  s.add_development_dependency 'mustache', "~> 0.99.8" if RUBY_VERSION =~ /^1[.]9[.]/
  s.add_development_dependency 'rake'
  s.add_development_dependency 'rdoc'
  s.add_development_dependency 'bundler'
  s.add_development_dependency 'ronn' unless RUBY_PLATFORM == 'java'
  s.add_development_dependency 'test-unit'

  s.required_ruby_version = '>= 1.9.3'

  s.requirements << 'GraphViz'
end
