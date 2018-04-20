# -*- encoding: utf-8 -*-
# stub: better_errors 2.4.0 ruby lib

Gem::Specification.new do |s|
  s.name = "better_errors".freeze
  s.version = "2.4.0"

  s.required_rubygems_version = Gem::Requirement.new(">= 0".freeze) if s.respond_to? :required_rubygems_version=
  s.require_paths = ["lib".freeze]
  s.authors = ["Charlie Somerville".freeze]
  s.date = "2017-10-13"
  s.description = "Provides a better error page for Rails and other Rack apps. Includes source code inspection, a live REPL and local/instance variable inspection for all stack frames.".freeze
  s.email = ["charlie@charliesomerville.com".freeze]
  s.homepage = "https://github.com/charliesome/better_errors".freeze
  s.licenses = ["MIT".freeze]
  s.required_ruby_version = Gem::Requirement.new(">= 2.0.0".freeze)
  s.rubygems_version = "2.5.2".freeze
  s.summary = "Better error page for Rails and other Rack apps".freeze

  s.installed_by_version = "2.5.2" if s.respond_to? :installed_by_version

  if s.respond_to? :specification_version then
    s.specification_version = 4

    if Gem::Version.new(Gem::VERSION) >= Gem::Version.new('1.2.0') then
      s.add_development_dependency(%q<rake>.freeze, ["~> 10.0"])
      s.add_development_dependency(%q<rspec>.freeze, ["~> 3.5"])
      s.add_development_dependency(%q<rspec-its>.freeze, [">= 0"])
      s.add_development_dependency(%q<yard>.freeze, [">= 0"])
      s.add_development_dependency(%q<kramdown>.freeze, [">= 0"])
      s.add_runtime_dependency(%q<erubi>.freeze, [">= 1.0.0"])
      s.add_runtime_dependency(%q<coderay>.freeze, [">= 1.0.0"])
      s.add_runtime_dependency(%q<rack>.freeze, [">= 0.9.0"])
    else
      s.add_dependency(%q<rake>.freeze, ["~> 10.0"])
      s.add_dependency(%q<rspec>.freeze, ["~> 3.5"])
      s.add_dependency(%q<rspec-its>.freeze, [">= 0"])
      s.add_dependency(%q<yard>.freeze, [">= 0"])
      s.add_dependency(%q<kramdown>.freeze, [">= 0"])
      s.add_dependency(%q<erubi>.freeze, [">= 1.0.0"])
      s.add_dependency(%q<coderay>.freeze, [">= 1.0.0"])
      s.add_dependency(%q<rack>.freeze, [">= 0.9.0"])
    end
  else
    s.add_dependency(%q<rake>.freeze, ["~> 10.0"])
    s.add_dependency(%q<rspec>.freeze, ["~> 3.5"])
    s.add_dependency(%q<rspec-its>.freeze, [">= 0"])
    s.add_dependency(%q<yard>.freeze, [">= 0"])
    s.add_dependency(%q<kramdown>.freeze, [">= 0"])
    s.add_dependency(%q<erubi>.freeze, [">= 1.0.0"])
    s.add_dependency(%q<coderay>.freeze, [">= 1.0.0"])
    s.add_dependency(%q<rack>.freeze, [">= 0.9.0"])
  end
end
