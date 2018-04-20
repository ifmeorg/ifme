$LOAD_PATH.unshift(
  File.expand_path(File.join(File.dirname(__FILE__), '../yard/lib'))
)
$LOAD_PATH.unshift(File.expand_path('.'))
$LOAD_PATH.uniq!

require 'rake'
require 'rake/clean'

CLOBBER.include('wiki')

begin
  require 'yard'
  require 'yard/rake/wikidoc_task'

  namespace :wiki do
    desc 'Generate Wiki Documentation with YARD'
    YARD::Rake::WikidocTask.new do |yardoc|
      yardoc.name = 'reference'
      yardoc.options = [
        '--verbose',
        '--markup', 'markdown',
        '-e', 'yard/lib/yard-google-code.rb',
        '-p', 'yard/templates',
        '-f', 'wiki',
        '-o', 'wiki'
      ]
      yardoc.files = [
        'lib/**/*.rb', 'ext/**/*.c', '-', 'README.md', 'CHANGELOG.md'
      ]
    end

    task 'generate' => ['wiki:reference', 'wiki:supported_apis']
  end
rescue LoadError
  # If yard isn't available, it's not the end of the world
  warn('YARD unavailable. Cannot fully generate wiki.')
end
