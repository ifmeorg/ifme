# frozen_string_literal: true

# Add your own tasks in files placed in lib/tasks ending in .rake,
# for example lib/tasks/capistrano.rake, and they will automatically be available to Rake.

require File.expand_path('../config/application', __FILE__)
Rails.application.load_tasks
require 'fileutils'
require 'yaml'

desc 'Quick command to execute the dockerized terminal for running commands'
task :app_cli do
  # Run the command ignoring the results
  sh('docker-compose', '-f', 'docker-compose.yml',
     '-f', 'docker-compose.test.yml',
     'run', '--rm', 'app', 'bash') || true
end

desc 'Quick command to launch the compose stack'
task :app_run do
  # Run the command ignoring the results
  sh('docker-compose', '-f', 'docker-compose.yml', 'up') || true
end

desc 'Automate the Config Setup for New Environments'
task :setup_workspace do
  secrets_example = "#{Rails.root}/config/secrets.example.yml"
  secrets_target = "#{Rails.root}/config/secrets.yml"
  FileUtils.cp(secrets_example, secrets_target)

  secret_key_base = generate_secret
  # Must renable the task or else it won't execute again
  Rake::Task['secret'].reenable
  devise_secret_key = generate_secret

  content = File.read(secrets_target)
  content.gsub!(/secret_key_base:$/, %(secret_key_base: "#{secret_key_base}"))
  content.gsub!(/devise_secret_key:$/, %(devise_secret_key: "#{devise_secret_key}"))
  File.write(secrets_target.to_s, content)
end

# Used code from http://stackoverflow.com/a/3543 on Rakefile output capture
def capture_stdout
  s = StringIO.new
  oldstdout = $stdout
  $stdout = s
  yield
  s.string
ensure
  $stdout = oldstdout
end

# Run the secret task, grab the output, strip the new lines
def generate_secret
  capture_stdout { Rake::Task['secret'].invoke }
    .strip
    .gsub(/\n\s+/, ' ')
    .squeeze(' ')
end
