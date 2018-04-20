begin
	require 'yard'
	require 'yard/rake/yardoc_task'

	YARD::Rake::YardocTask.new do |t|
  	t.files   = ['lib/**/*.rb', 'generated/**/*.rb']
  	t.options = ['--verbose', '--markup', 'markdown']
	end
rescue LoadError
  puts "YARD not available"
end
