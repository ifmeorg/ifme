# -*- ruby -*-
require 'rspec/core/rake_task'
require 'rubocop/rake_task'
require 'bundler/gem_tasks'

desc 'Run Rubocop to check for style violations'
RuboCop::RakeTask.new

desc 'Run rake task'
RSpec::Core::RakeTask.new(:spec)

desc 'Does rubocop lint and runs the specs'
task all: [:rubocop, :spec]

task default: :all
