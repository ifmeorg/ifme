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
  dev_example = Rails.root + 'config/env/development.example.env'
  dev_target = Rails.root + 'config/env/development.env'
  FileUtils.cp(dev_example, dev_target)

  test_example = Rails.root + 'config/env/test.example.env'
  test_target = Rails.root + 'config/env/test.env'
  FileUtils.cp(test_example, test_target)

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
  secret_key_base = capture_stdout { Rake::Task['secret'].invoke }.strip.gsub(/\n\s+/, ' ').squeeze(' ')
  # Must renable the task or else it won't execute again
  Rake::Task['secret'].reenable
  devise_secret_key = capture_stdout { Rake::Task['secret'].invoke }.strip.gsub(/\n\s+/, ' ').squeeze(' ')

  # insert the secrets into the files
  files = [dev_target.to_s, test_target.to_s]
  files.each {|f| File.write(f, File.read(f).gsub(/SECRET_KEY_BASE=""/, 'SECRET_KEY_BASE="%s"' % [secret_key_base]))}
  files.each {|f| File.write(f, File.read(f).gsub(/DEVISE_SECRET_KEY=""/, 'DEVISE_SECRET_KEY="%s"' % [devise_secret_key]))}
end
