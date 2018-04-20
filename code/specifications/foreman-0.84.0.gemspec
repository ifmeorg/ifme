# -*- encoding: utf-8 -*-
# stub: foreman 0.84.0 ruby lib

Gem::Specification.new do |s|
  s.name = "foreman".freeze
  s.version = "0.84.0"

  s.required_rubygems_version = Gem::Requirement.new(">= 0".freeze) if s.respond_to? :required_rubygems_version=
  s.require_paths = ["lib".freeze]
  s.authors = ["David Dollar".freeze]
  s.date = "2017-03-28"
  s.description = "Process manager for applications with multiple components".freeze
  s.email = "ddollar@gmail.com".freeze
  s.executables = ["foreman".freeze]
  s.files = ["bin/foreman".freeze]
  s.homepage = "http://github.com/ddollar/foreman".freeze
  s.licenses = ["MIT".freeze]
  s.rubygems_version = "2.5.2".freeze
  s.summary = "Process manager for applications with multiple components".freeze

  s.installed_by_version = "2.5.2" if s.respond_to? :installed_by_version

  if s.respond_to? :specification_version then
    s.specification_version = 4

    if Gem::Version.new(Gem::VERSION) >= Gem::Version.new('1.2.0') then
      s.add_runtime_dependency(%q<thor>.freeze, ["~> 0.19.1"])
    else
      s.add_dependency(%q<thor>.freeze, ["~> 0.19.1"])
    end
  else
    s.add_dependency(%q<thor>.freeze, ["~> 0.19.1"])
  end
end
