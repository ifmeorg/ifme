# -*- encoding: utf-8 -*-
# stub: certified 1.0.0 ruby .

Gem::Specification.new do |s|
  s.name = "certified".freeze
  s.version = "1.0.0"

  s.required_rubygems_version = Gem::Requirement.new(">= 0".freeze) if s.respond_to? :required_rubygems_version=
  s.require_paths = [".".freeze]
  s.authors = ["Stevie Graham".freeze]
  s.date = "2014-07-19"
  s.description = "Ensure net/https uses OpenSSL::SSL::VERIFY_PEER to verify SSL certificates and provides certificate bundle in case OpenSSL cannot find one".freeze
  s.email = "sjtgraham@mac.com".freeze
  s.executables = ["certified-update".freeze]
  s.files = ["bin/certified-update".freeze]
  s.homepage = "http://github.com/stevegraham/certified".freeze
  s.post_install_message = "IMPORTANT: Remember to use the included executable `certifed-update` regularly to keep your certificate bundle up to date.".freeze
  s.required_ruby_version = Gem::Requirement.new(">= 1.8.7".freeze)
  s.rubygems_version = "2.5.2".freeze
  s.summary = "Ensure net/https uses OpenSSL::SSL::VERIFY_PEER to verify SSL certificates and provides certificate bundle in case OpenSSL cannot find one".freeze

  s.installed_by_version = "2.5.2" if s.respond_to? :installed_by_version
end
