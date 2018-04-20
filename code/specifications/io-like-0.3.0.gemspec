# -*- encoding: utf-8 -*-
# stub: io-like 0.3.0 ruby lib

Gem::Specification.new do |s|
  s.name = "io-like".freeze
  s.version = "0.3.0"

  s.required_rubygems_version = Gem::Requirement.new(">= 0".freeze) if s.respond_to? :required_rubygems_version=
  s.require_paths = ["lib".freeze]
  s.authors = ["Jeremy Bopp".freeze]
  s.date = "2009-04-29"
  s.description = "The IO::Like module provides the methods of an IO object based upon on a few simple methods provided by the including class: unbuffered_read, unbuffered_write, and unbuffered_seek.  These methods provide the underlying read, write, and seek support respectively, and only the method or methods necessary to the correct operation of the IO aspects of the including class need to be provided.  Missing functionality will cause the resulting object to appear read-only, write-only, and/or unseekable depending on which underlying methods are absent.  Additionally, read and write operations which are buffered in IO are buffered with independently configurable buffer sizes.  Duplexed objects (those with separate read and write streams) are also supported.".freeze
  s.email = "jeremy at bopp dot net".freeze
  s.extra_rdoc_files = ["CONTRIBUTORS".freeze, "HACKING".freeze, "LICENSE".freeze, "LICENSE.rubyspec".freeze, "GPL".freeze, "LEGAL".freeze, "NEWS".freeze, "README".freeze]
  s.files = ["CONTRIBUTORS".freeze, "GPL".freeze, "HACKING".freeze, "LEGAL".freeze, "LICENSE".freeze, "LICENSE.rubyspec".freeze, "NEWS".freeze, "README".freeze]
  s.homepage = "http://io-like.rubyforge.org".freeze
  s.rdoc_options = ["--title".freeze, "IO::Like Documentation".freeze, "--charset".freeze, "utf-8".freeze, "--line-numbers".freeze, "--inline-source".freeze]
  s.required_ruby_version = Gem::Requirement.new(">= 1.8.1".freeze)
  s.rubyforge_project = "io-like".freeze
  s.rubygems_version = "2.5.2".freeze
  s.summary = "A module which provides the functionality of an IO object to any class which provides a couple of simple methods.".freeze

  s.installed_by_version = "2.5.2" if s.respond_to? :installed_by_version
end
