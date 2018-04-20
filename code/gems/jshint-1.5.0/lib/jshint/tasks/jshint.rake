require 'jshint'
require 'jshint/reporters'
require 'jshint/cli'

namespace :jshint do
  desc "Runs JSHint, the JavaScript lint tool over this project's JavaScript assets"
  task :lint, [:config_path] => :environment do |_, args|
    # Our own argument parsing, since rake jshint will push extra nil's.
    reporter_name = args.extras[0] || :Default
    result_file = args.extras[1]
    config_path = args[:config_path] || nil

    linter = Jshint::Cli::run(reporter_name, result_file, config_path)
    fail if linter.errors.any? { |_, errors| errors.any? }
  end

  desc "Copies the default JSHint options to your Rails application"
  task :install_config => :environment do
    source_file = File.join(Jshint.root, 'config', 'jshint.yml')
    source_dest = File.join(Rails.root, 'config', '')
    FileUtils.cp(source_file, source_dest)
  end
  task :all => [:lint]
end

desc "Runs JSHint, the JavaScript lint tool over this projects JavaScript assets"
task :jshint => ["jshint:all"]
