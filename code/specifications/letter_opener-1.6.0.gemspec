# -*- encoding: utf-8 -*-
# stub: letter_opener 1.6.0 ruby lib

Gem::Specification.new do |s|
  s.name = "letter_opener".freeze
  s.version = "1.6.0"

  s.required_rubygems_version = Gem::Requirement.new(">= 1.3.4".freeze) if s.respond_to? :required_rubygems_version=
  s.require_paths = ["lib".freeze]
  s.authors = ["Ryan Bates".freeze]
  s.date = "2018-01-10"
  s.description = "When mail is sent from your application, Letter Opener will open a preview in the browser instead of sending.".freeze
  s.email = "ryan@railscasts.com".freeze
  s.homepage = "http://github.com/ryanb/letter_opener".freeze
  s.licenses = ["MIT".freeze]
  s.rubyforge_project = "letter_opener".freeze
  s.rubygems_version = "2.5.2".freeze
  s.summary = "Preview mail in browser instead of sending.".freeze

  s.installed_by_version = "2.5.2" if s.respond_to? :installed_by_version

  if s.respond_to? :specification_version then
    s.specification_version = 4

    if Gem::Version.new(Gem::VERSION) >= Gem::Version.new('1.2.0') then
      s.add_runtime_dependency(%q<launchy>.freeze, ["~> 2.2"])
      s.add_development_dependency(%q<rspec>.freeze, ["~> 3.5.0"])
      s.add_development_dependency(%q<mail>.freeze, ["~> 2.6.0"])
    else
      s.add_dependency(%q<launchy>.freeze, ["~> 2.2"])
      s.add_dependency(%q<rspec>.freeze, ["~> 3.5.0"])
      s.add_dependency(%q<mail>.freeze, ["~> 2.6.0"])
    end
  else
    s.add_dependency(%q<launchy>.freeze, ["~> 2.2"])
    s.add_dependency(%q<rspec>.freeze, ["~> 3.5.0"])
    s.add_dependency(%q<mail>.freeze, ["~> 2.6.0"])
  end
end
