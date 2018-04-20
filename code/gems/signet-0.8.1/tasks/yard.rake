require 'rake/clean'

CLOBBER.include('doc')

require 'yard'
require 'yard/rake/yardoc_task'

namespace :doc do
  desc 'Generate Yardoc documentation'
  YARD::Rake::YardocTask.new do |yardoc|
    yardoc.name = 'yard'
    yardoc.options = ['--verbose', '--markup', 'markdown']
    yardoc.files = [
      'lib/**/*.rb', 'ext/**/*.c', '-',
      'README.md', 'CHANGELOG.md', 'LICENSE'
    ]
  end
end

desc 'Alias to doc:yard'
task 'doc' => 'doc:yard'
