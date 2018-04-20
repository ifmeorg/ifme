# -*- encoding: utf-8 -*-
# stub: resque-scheduler 4.2.0 ruby lib

Gem::Specification.new do |s|
  s.name = "resque-scheduler".freeze
  s.version = "4.2.0"

  s.required_rubygems_version = Gem::Requirement.new(">= 0".freeze) if s.respond_to? :required_rubygems_version=
  s.require_paths = ["lib".freeze]
  s.authors = ["Ben VandenBos".freeze]
  s.date = "2016-04-29"
  s.description = "    Light weight job scheduling on top of Resque.\n    Adds methods enqueue_at/enqueue_in to schedule jobs in the future.\n    Also supports queueing jobs on a fixed, cron-like schedule.\n".freeze
  s.email = ["bvandenbos@gmail.com".freeze]
  s.executables = ["resque-scheduler".freeze]
  s.files = ["bin/resque-scheduler".freeze]
  s.homepage = "http://github.com/resque/resque-scheduler".freeze
  s.licenses = ["MIT".freeze]
  s.rubygems_version = "2.5.2".freeze
  s.summary = "Light weight job scheduling on top of Resque".freeze

  s.installed_by_version = "2.5.2" if s.respond_to? :installed_by_version

  if s.respond_to? :specification_version then
    s.specification_version = 4

    if Gem::Version.new(Gem::VERSION) >= Gem::Version.new('1.2.0') then
      s.add_development_dependency(%q<bundler>.freeze, [">= 0"])
      s.add_development_dependency(%q<json>.freeze, [">= 0"])
      s.add_development_dependency(%q<kramdown>.freeze, [">= 0"])
      s.add_development_dependency(%q<minitest>.freeze, [">= 0"])
      s.add_development_dependency(%q<mocha>.freeze, [">= 0"])
      s.add_development_dependency(%q<pry>.freeze, [">= 0"])
      s.add_development_dependency(%q<rack-test>.freeze, [">= 0"])
      s.add_development_dependency(%q<rake>.freeze, [">= 0"])
      s.add_development_dependency(%q<simplecov>.freeze, [">= 0"])
      s.add_development_dependency(%q<test-unit>.freeze, [">= 0"])
      s.add_development_dependency(%q<yard>.freeze, [">= 0"])
      s.add_development_dependency(%q<rubocop>.freeze, ["~> 0.35.1"])
      s.add_runtime_dependency(%q<mono_logger>.freeze, ["~> 1.0"])
      s.add_runtime_dependency(%q<redis>.freeze, ["~> 3.0"])
      s.add_runtime_dependency(%q<resque>.freeze, ["~> 1.25"])
      s.add_runtime_dependency(%q<rufus-scheduler>.freeze, ["~> 3.2"])
    else
      s.add_dependency(%q<bundler>.freeze, [">= 0"])
      s.add_dependency(%q<json>.freeze, [">= 0"])
      s.add_dependency(%q<kramdown>.freeze, [">= 0"])
      s.add_dependency(%q<minitest>.freeze, [">= 0"])
      s.add_dependency(%q<mocha>.freeze, [">= 0"])
      s.add_dependency(%q<pry>.freeze, [">= 0"])
      s.add_dependency(%q<rack-test>.freeze, [">= 0"])
      s.add_dependency(%q<rake>.freeze, [">= 0"])
      s.add_dependency(%q<simplecov>.freeze, [">= 0"])
      s.add_dependency(%q<test-unit>.freeze, [">= 0"])
      s.add_dependency(%q<yard>.freeze, [">= 0"])
      s.add_dependency(%q<rubocop>.freeze, ["~> 0.35.1"])
      s.add_dependency(%q<mono_logger>.freeze, ["~> 1.0"])
      s.add_dependency(%q<redis>.freeze, ["~> 3.0"])
      s.add_dependency(%q<resque>.freeze, ["~> 1.25"])
      s.add_dependency(%q<rufus-scheduler>.freeze, ["~> 3.2"])
    end
  else
    s.add_dependency(%q<bundler>.freeze, [">= 0"])
    s.add_dependency(%q<json>.freeze, [">= 0"])
    s.add_dependency(%q<kramdown>.freeze, [">= 0"])
    s.add_dependency(%q<minitest>.freeze, [">= 0"])
    s.add_dependency(%q<mocha>.freeze, [">= 0"])
    s.add_dependency(%q<pry>.freeze, [">= 0"])
    s.add_dependency(%q<rack-test>.freeze, [">= 0"])
    s.add_dependency(%q<rake>.freeze, [">= 0"])
    s.add_dependency(%q<simplecov>.freeze, [">= 0"])
    s.add_dependency(%q<test-unit>.freeze, [">= 0"])
    s.add_dependency(%q<yard>.freeze, [">= 0"])
    s.add_dependency(%q<rubocop>.freeze, ["~> 0.35.1"])
    s.add_dependency(%q<mono_logger>.freeze, ["~> 1.0"])
    s.add_dependency(%q<redis>.freeze, ["~> 3.0"])
    s.add_dependency(%q<resque>.freeze, ["~> 1.25"])
    s.add_dependency(%q<rufus-scheduler>.freeze, ["~> 3.2"])
  end
end
