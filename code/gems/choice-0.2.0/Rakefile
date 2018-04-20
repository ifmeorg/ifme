require 'rubygems'
require 'rubygems/gem_runner'
require 'rake'
require 'rake/testtask'
require 'rdoc/task'
require './lib/choice/version'

PACKAGE_VERSION = Choice::Version::STRING

desc "Default task"
task :default => [ :test ]

Rake::TestTask.new :test do |t|
  t.test_files = [ "test/test*" ]
end

desc "Clean generated files"
task :clean do
  rm_rf "choice-#{PACKAGE_VERSION}.gem"
end

desc "Prepackage warnings and reminders"
task :prepackage do
  unless ENV["OK"] == "yes"
    puts "========================================================="
    puts " Please check that the following files have been updated"
    puts " in preparation for release #{PACKAGE_VERSION}:"
    puts
    puts "   README.rdoc (with latest info)"
    puts "   CHANGELOG (with the recent changes)"
    puts "   lib/choice/version.rb (with current version number)"
    puts
    puts " Did you remember to 'rake tag'?"
    puts
    puts " If you are sure these have all been taken care of, re-run"
    puts " rake with 'OK=yes'."
    puts "========================================================="
    puts

    abort
  end
end

desc "Tag the current trunk with the current release version"
task :tag do
  tag = "v#{PACKAGE_VERSION}"
  warn "WARNING: this will tag using the tag #{tag} and push the ref to git://www.github.com/defunkt/choice"
  warn "If you do not wish to continue, you have 5 seconds to cancel by pressing CTRL-C..."
  5.times { |i| print "#{5-i} "; $stdout.flush; sleep 1 }
  system "git tag -a #{tag} -m \"Tagging the #{tag} release\""
  system "git push origin #{tag}"
end

task :gem do
  system "gem build choice.gemspec"
end

desc "Build all packages"
task :package => [ :prepackage, :test, :gem ]
