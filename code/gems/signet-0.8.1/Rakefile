lib_dir = File.expand_path(File.join(File.dirname(__FILE__), "lib"))
$:.unshift(lib_dir)
$:.uniq!

require 'rubygems'
require 'rake'
require "bundler/gem_tasks"

require File.join(File.dirname(__FILE__), 'lib/signet', 'version')

PKG_DISPLAY_NAME   = 'Signet'
PKG_NAME           = PKG_DISPLAY_NAME.downcase
PKG_VERSION        = Signet::VERSION::STRING
PKG_FILE_NAME      = "#{PKG_NAME}-#{PKG_VERSION}"

RELEASE_NAME       = "REL #{PKG_VERSION}"

PKG_AUTHOR         = "Bob Aman"
PKG_AUTHOR_EMAIL   = "bobaman@google.com"
PKG_HOMEPAGE       = "http://code.google.com/p/oauth-signet/"
PKG_DESCRIPTION    = <<-TEXT
Signet is an OAuth 1.0 / OAuth 2.0 implementation.
TEXT
PKG_SUMMARY        = PKG_DESCRIPTION

PKG_FILES = FileList[
    "lib/**/*", "spec/**/*", "vendor/**/*",
    "tasks/**/*", "website/**/*",
    "[A-Z]*", "Rakefile"
].exclude(/database\.yml/).exclude(/[_\.]git$/).exclude(/Gemfile\.lock/)

RCOV_ENABLED = !!(RUBY_PLATFORM != 'java' && RUBY_VERSION =~ /^1\.8/)
if RCOV_ENABLED
  task :default => 'spec:rcov'
else
  task :default => 'spec:normal'
end

WINDOWS = (RUBY_PLATFORM =~ /mswin|win32|mingw|bccwin|cygwin/) rescue false
SUDO = WINDOWS ? '' : ('sudo' unless ENV['SUDOLESS'])

Dir['tasks/**/*.rake'].each { |rake| load rake }
