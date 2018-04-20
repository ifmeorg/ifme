# -*- encoding: utf-8 -*-
# stub: pusher-signature 0.1.8 ruby lib

Gem::Specification.new do |s|
  s.name = "pusher-signature".freeze
  s.version = "0.1.8"

  s.required_rubygems_version = Gem::Requirement.new(">= 0".freeze) if s.respond_to? :required_rubygems_version=
  s.require_paths = ["lib".freeze]
  s.authors = ["Martyn Loughran".freeze, "Pusher Ltd".freeze]
  s.date = "2015-09-29"
  s.description = "Simple key/secret based authentication for apis".freeze
  s.email = ["me@mloughran.com".freeze, "support@pusher.com".freeze]
  s.homepage = "http://github.com/pusher/pusher-signature".freeze
  s.licenses = ["MIT".freeze]
  s.rubygems_version = "2.5.2".freeze
  s.summary = "Simple key/secret based authentication for apis".freeze

  s.installed_by_version = "2.5.2" if s.respond_to? :installed_by_version

  if s.respond_to? :specification_version then
    s.specification_version = 4

    if Gem::Version.new(Gem::VERSION) >= Gem::Version.new('1.2.0') then
      s.add_development_dependency(%q<rspec>.freeze, ["= 2.13.0"])
      s.add_development_dependency(%q<em-spec>.freeze, ["= 0.2.6"])
    else
      s.add_dependency(%q<rspec>.freeze, ["= 2.13.0"])
      s.add_dependency(%q<em-spec>.freeze, ["= 0.2.6"])
    end
  else
    s.add_dependency(%q<rspec>.freeze, ["= 2.13.0"])
    s.add_dependency(%q<em-spec>.freeze, ["= 0.2.6"])
  end
end
