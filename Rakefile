# frozen_string_literal: true

# Add your own tasks in files placed in lib/tasks ending in .rake,
# for example lib/tasks/capistrano.rake, and they will automatically be
# available to Rake.

require File.expand_path('config/application', __dir__)
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
  SECRETS = {
    SECRET_KEY_BASE: generate_secret,
    DEVISE_SECRET_KEY: generate_secret
  }.freeze

  %w[development test].each do |environment|
    example = Rails.root.join('config', 'env', "#{environment}.example.env")
    target = Rails.root.join('config', 'env', "#{environment}.env")
    FileUtils.cp(example, target)

    # insert the secrets into the file
    content = File.read(target)
    %w[SECRET_KEY_BASE DEVISE_SECRET_KEY].each do |key|
      content.sub!(%(#{key}=""), %(#{key}="#{SECRETS[key.to_sym]}"))
    end
    File.write(target, content)
  end
end

# Run the secret task, grab the output, strip the new lines
def generate_secret
  s = StringIO.new
  oldstdout = $stdout
  $stdout = s
  Rake::Task['secret'].invoke
  s.string.strip
ensure
  # Must renable the task or else it won't execute again
  Rake::Task['secret'].reenable
  $stdout = oldstdout
end
