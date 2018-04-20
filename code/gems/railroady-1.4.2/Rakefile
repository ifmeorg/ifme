#!/usr/bin/env rake
require 'bundler/gem_tasks'

require 'rake/testtask'

Rake::TestTask.new do |t|
  t.libs << 'lib/railroady'
  t.test_files = FileList['test/lib/railroady/*_spec.rb']
  t.verbose = true
end

task default: :test
