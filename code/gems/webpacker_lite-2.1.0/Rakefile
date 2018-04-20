# frozen_string_literal: true
require "bundler/gem_tasks"
require "rake/testtask"

# Executes a string or an array of strings in a shell in the given directory
def sh_in_dir(dir, shell_commands)
  shell_commands = [shell_commands] if shell_commands.is_a?(String)
  shell_commands.each { |shell_command| sh %(cd #{dir} && #{shell_command.strip}) }
end

def gem_root
  File.expand_path("../.", __FILE__)
end

Rake::TestTask.new(:test) do |t|
  t.libs << "test"
  t.libs << "lib"
  t.test_files = FileList["test/**/*_test.rb"]
  t.verbose = true
end

desc "Run Rubocop as shell"
task :rubocop do
  sh_in_dir(gem_root, "bundle exec rubocop .")
end

task default: [:test, :rubocop]
