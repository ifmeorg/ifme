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
  secret_key_base = capture_stdout { Rake::Task["secret"].invoke }.strip.gsub(/\n\s+/, " ").squeeze(" ")
  # Must renable the task or else it won't execute again
  Rake::Task["secret"].reenable
  devise_secret_key = capture_stdout { Rake::Task["secret"].invoke }.strip.gsub(/\n\s+/, " ").squeeze(" ")
  
  # insert the secrets into the files
  files = [dev_target.to_s, test_target.to_s]
  files.each{|f| File.write(f, File.read(f).gsub(/SECRET_KEY_BASE=""/, 'SECRET_KEY_BASE="%s"' % [secret_key_base]))}
  files.each{|f| File.write(f, File.read(f).gsub(/DEVISE_SECRET_KEY=""/, 'DEVISE_SECRET_KEY="%s"' % [devise_secret_key]))}
end

desc 'Start C9 Postgres'
task :c9_psql_start do
  if !ENV.has_key?('C9_USER')
    raise 'not on cloud9 ide'
  end

  # Run the command ignoring the results
  sh('sudo', 'service', 'postgresql', 'start') || true
end

desc 'Provision C9 Postgres'
task :c9_psql_setup do
  if !ENV.has_key?('C9_USER')
    raise 'not on cloud9 ide'
  end

  # automating the steps from https://github.com/Aerogami/guides/wiki/Cloud9-workspace-setup-with-Rails-and-Postgresql#update-template1-postgresql-for-databaseyml-on-cloud9
  update_template = %Q(UPDATE pg_database SET datistemplate = FALSE WHERE datname = 'template1';)
  sh('sudo', 'sudo', '-u', 'postgres', 'psql', '-c', update_template) || true;

  drop_template =  %Q(DROP DATABASE template1;)
  sh('sudo', 'sudo', '-u', 'postgres', 'psql', '-c', drop_template) || true;

  create_template =  %Q(CREATE DATABASE template1 WITH TEMPLATE = template0 ENCODING = 'UNICODE';)
  sh('sudo', 'sudo', '-u', 'postgres', 'psql', '-c', create_template) || true;

  replace_template =  %Q(UPDATE pg_database SET datistemplate = TRUE WHERE datname = 'template1';)
  sh('sudo', 'sudo', '-u', 'postgres', 'psql', '-c', replace_template) || true;

  vacuum_freeze =  %Q(VACUUM FREEZE;)
  sh('sudo', 'sudo', '-u', 'postgres', 'psql', '-d', 'template1', '-c', vacuum_freeze) || true;
end

desc 'Start Rails on Cloud9 IDE'
task :c9_rails_server do
  if !ENV.has_key?('C9_USER')
    raise 'not on cloud9 ide'
  end
  # Run the command ignoring the results
  sh('rails', 's', '-b', ENV['IP'], '-p',  ENV['PORT']) || true
end