# encoding: utf-8

require "bundler"
Bundler::GemHelper.install_tasks

require "rake/testtask"
task default: :test

Rake::TestTask.new do |t|
  t.pattern = "spec/**/*_spec.rb"
  t.verbose = true
end
