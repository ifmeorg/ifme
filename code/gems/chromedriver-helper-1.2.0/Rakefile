require "bundler/gem_tasks"
require 'rspec/core/rake_task'
require 'concourse'

RSpec::Core::RakeTask.new(:spec)

task :default => :spec

Concourse.new("chromedriver-helper").create_tasks!
