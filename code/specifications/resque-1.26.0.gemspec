# -*- encoding: utf-8 -*-
# stub: resque 1.26.0 ruby lib

Gem::Specification.new do |s|
  s.name = "resque".freeze
  s.version = "1.26.0"

  s.required_rubygems_version = Gem::Requirement.new(">= 0".freeze) if s.respond_to? :required_rubygems_version=
  s.require_paths = ["lib".freeze]
  s.authors = ["Chris Wanstrath".freeze, "Steve Klabnik".freeze, "Terence Lee".freeze]
  s.date = "2016-03-11"
  s.description = "    Resque is a Redis-backed Ruby library for creating background jobs,\n    placing those jobs on multiple queues, and processing them later.\n\n    Background jobs can be any Ruby class or module that responds to\n    perform. Your existing classes can easily be converted to background\n    jobs or you can create new classes specifically to do work. Or, you\n    can do both.\n\n    Resque is heavily inspired by DelayedJob (which rocks) and is\n    comprised of three parts:\n\n    * A Ruby library for creating, querying, and processing jobs\n    * A Rake task for starting a worker which processes jobs\n    * A Sinatra app for monitoring queues, jobs, and workers.\n".freeze
  s.email = "steve@steveklabnik.com".freeze
  s.executables = ["resque".freeze, "resque-web".freeze]
  s.extra_rdoc_files = ["LICENSE".freeze, "README.markdown".freeze]
  s.files = ["LICENSE".freeze, "README.markdown".freeze, "bin/resque".freeze, "bin/resque-web".freeze]
  s.homepage = "http://resque.github.io/".freeze
  s.rdoc_options = ["--charset=UTF-8".freeze]
  s.rubygems_version = "2.5.2".freeze
  s.summary = "Resque is a Redis-backed queueing system.".freeze

  s.installed_by_version = "2.5.2" if s.respond_to? :installed_by_version

  if s.respond_to? :specification_version then
    s.specification_version = 4

    if Gem::Version.new(Gem::VERSION) >= Gem::Version.new('1.2.0') then
      s.add_runtime_dependency(%q<redis-namespace>.freeze, ["~> 1.3"])
      s.add_runtime_dependency(%q<vegas>.freeze, ["~> 0.1.2"])
      s.add_runtime_dependency(%q<sinatra>.freeze, [">= 0.9.2"])
      s.add_runtime_dependency(%q<multi_json>.freeze, ["~> 1.0"])
      s.add_runtime_dependency(%q<mono_logger>.freeze, ["~> 1.0"])
    else
      s.add_dependency(%q<redis-namespace>.freeze, ["~> 1.3"])
      s.add_dependency(%q<vegas>.freeze, ["~> 0.1.2"])
      s.add_dependency(%q<sinatra>.freeze, [">= 0.9.2"])
      s.add_dependency(%q<multi_json>.freeze, ["~> 1.0"])
      s.add_dependency(%q<mono_logger>.freeze, ["~> 1.0"])
    end
  else
    s.add_dependency(%q<redis-namespace>.freeze, ["~> 1.3"])
    s.add_dependency(%q<vegas>.freeze, ["~> 0.1.2"])
    s.add_dependency(%q<sinatra>.freeze, [">= 0.9.2"])
    s.add_dependency(%q<multi_json>.freeze, ["~> 1.0"])
    s.add_dependency(%q<mono_logger>.freeze, ["~> 1.0"])
  end
end
