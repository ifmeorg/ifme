#!/usr/bin/env rake
require 'bundler/gem_tasks'
require 'rake/testtask'

Rake::TestTask.new :test do |t|
  require 'fileutils'
  t.libs << 'lib'
  t.libs << 'test'
  test_files = FileList['test/**/*_{test,spec}.rb']
  test_files.exclude('test/rails/*', 'test/haml/*')
  t.test_files = test_files
  t.verbose = true
end

task :default => [:test]
