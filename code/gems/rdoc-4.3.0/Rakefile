$:.unshift File.expand_path 'lib'
require 'rdoc'
require 'hoe'

ENV['BENCHMARK'] = 'yes'

task :docs    => :generate
task :test    => :generate

PARSER_FILES = %w[
  lib/rdoc/rd/block_parser.rb
  lib/rdoc/rd/inline_parser.rb
  lib/rdoc/markdown.rb
  lib/rdoc/markdown/literals_1_8.rb
  lib/rdoc/markdown/literals_1_9.rb
]

Hoe.plugin :git
Hoe.plugin :kpeg
Hoe.plugin :minitest
Hoe.plugin :travis

$rdoc_rakefile = true

hoe = Hoe.spec 'rdoc' do
  developer 'Eric Hodel', 'drbrain@segment7.net'
  developer 'Dave Thomas', ''
  developer 'Phil Hagelberg', 'technomancy@gmail.com'
  developer 'Tony Strauss', 'tony.strauss@designingpatterns.com'

  self.rsync_args = '-avz'
  rdoc_locations << 'docs.seattlerb.org:/data/www/docs.seattlerb.org/rdoc/'
  rdoc_locations << 'drbrain@rubyforge.org:/var/www/gforge-projects/rdoc/'

  self.licenses << 'Ruby'
  self.readme_file  = 'README.rdoc'
  self.history_file = 'History.rdoc'
  self.testlib = :minitest
  self.extra_rdoc_files += %w[
    CVE-2013-0256.rdoc
    CONTRIBUTING.rdoc
    ExampleMarkdown.md
    ExampleRDoc.rdoc
    History.rdoc
    LEGAL.rdoc
    LICENSE.rdoc
    README.rdoc
    RI.rdoc
    TODO.rdoc
  ]

  self.clean_globs += PARSER_FILES
  self.kpeg_flags = '-fsv' if self.respond_to? :kpeg_flags= # no plugin

  require_ruby_version '>= 1.9.3'
  extra_dev_deps << ['racc',     '~> 1.4', '> 1.4.10']
  extra_dev_deps << ['minitest', '~> 4']

  extra_rdoc_files << 'Rakefile'
  spec_extras['required_rubygems_version'] = '>= 1.3'
  spec_extras['homepage'] = 'http://docs.seattlerb.org/rdoc'
end

hoe.test_prelude = 'gem "minitest", "~> 4.0"'

def rake(*args)
  sh $0, *args
end

need_racc = PARSER_FILES.any? do |rb_file|
  ry_file = rb_file.gsub(/\.rb\z/, ".ry")
  not File.exist?(rb_file) or
    (File.exist?(ry_file) and File.mtime(rb_file) < File.mtime(ry_file))
end

if need_racc
  Rake::Task["default"].prerequisites.clear
  task :default do
    rake "check_extra_deps"
    rake "install_plugins"
    rake "newb"
  end
end

Rake::Task['docs'].actions.clear
task :docs do
  $LOAD_PATH.unshift 'lib'
  require 'rdoc'

  options = RDoc::Options.new
  options.title = "rdoc #{RDoc::VERSION} Documentation"
  options.op_dir = 'doc'
  options.main_page = 'README.rdoc'
  options.files = hoe.spec.extra_rdoc_files + %w[lib]
  options.setup_generator 'darkfish'

  RDoc::RDoc.new.document options
end

# requires ruby 1.8 and ruby 1.8 to build
hoe.clean_globs -= PARSER_FILES.grep(/literals_/)

task :generate => :isolate
task :generate => PARSER_FILES
task :check_manifest => :generate

rule '.rb' => '.ry' do |t|
  racc = Gem.bin_path 'racc', 'racc'

  ruby "-rubygems #{racc} -l -o #{t.name} #{t.source}"
end

path = "pkg/#{hoe.spec.full_name}"

package_parser_files = PARSER_FILES.map do |parser_file|
  package_parser_file = "#{path}/#{parser_file}"
  file package_parser_file => parser_file # ensure copy runs before racc
  package_parser_file
end

task "#{path}.gem" => package_parser_files

# These tasks expect to have the following directory structure:
#
#   git/git.rubini.us/code # Rubinius git HEAD checkout
#   svn/ruby/trunk         # ruby subversion HEAD checkout
#   svn/rdoc/trunk         # RDoc subversion HEAD checkout
#
# If you don't have this directory structure, set RUBY_PATH and/or
# RUBINIUS_PATH.

diff_options = "-urpN --exclude '*svn*' --exclude '*swp' --exclude '*rbc'"
rsync_options = "-avP --exclude '*svn*' --exclude '*swp' --exclude '*rbc' --exclude '*.rej' --exclude '*.orig' --exclude '*.kpeg' --exclude '*.ry' --exclude 'literals_1_8.rb' --exclude 'gauntlet_rdoc.rb'"

rubinius_dir = ENV['RUBINIUS_PATH'] || '../../../git/git.rubini.us/code'
ruby_dir = ENV['RUBY_PATH'] || '../../svn/ruby/trunk'

desc "Updates Ruby HEAD with the currently checked-out copy of RDoc."
task :update_ruby do
  sh "rsync #{rsync_options} bin/rdoc #{ruby_dir}/bin/rdoc"
  sh "rsync #{rsync_options} bin/ri #{ruby_dir}/bin/ri"
  sh "rsync #{rsync_options} lib/ #{ruby_dir}/lib"
  sh "rsync #{rsync_options} test/ #{ruby_dir}/test/rdoc"
end

desc "Diffs Ruby HEAD with the currently checked-out copy of RDoc."
task :diff_ruby do
  options = "-urpN --exclude '*svn*' --exclude '*swp' --exclude '*rbc'"

  sh "diff #{diff_options} bin/rdoc #{ruby_dir}/bin/rdoc; true"
  sh "diff #{diff_options} bin/ri #{ruby_dir}/bin/ri; true"
  sh "diff #{diff_options} lib/rdoc.rb #{ruby_dir}/lib/rdoc.rb; true"
  sh "diff #{diff_options} lib/rdoc #{ruby_dir}/lib/rdoc; true"
  sh "diff #{diff_options} test #{ruby_dir}/test/rdoc; true"
end

desc "Updates Rubinius HEAD with the currently checked-out copy of RDoc."
task :update_rubinius do
  sh "rsync #{rsync_options} bin/rdoc #{rubinius_dir}/lib/bin/rdoc.rb"
  sh "rsync #{rsync_options} bin/ri #{rubinius_dir}/lib/bin/ri.rb"
  sh "rsync #{rsync_options} lib/ #{rubinius_dir}/lib"
  sh "rsync #{rsync_options} test/ #{rubinius_dir}/test/rdoc"
end

desc "Diffs Rubinius HEAD with the currently checked-out copy of RDoc."
task :diff_rubinius do
  sh "diff #{diff_options} bin/rdoc #{rubinius_dir}/lib/bin/rdoc.rb; true"
  sh "diff #{diff_options} bin/ri #{rubinius_dir}/lib/bin/ri.rb; true"
  sh "diff #{diff_options} lib/rdoc.rb #{rubinius_dir}/lib/rdoc.rb; true"
  sh "diff #{diff_options} lib/rdoc #{rubinius_dir}/lib/rdoc; true"
  sh "diff #{diff_options} test #{rubinius_dir}/test/rdoc; true"
end
