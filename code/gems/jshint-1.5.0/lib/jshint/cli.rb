module Jshint
  module Cli
    def self.run(reporter_name = :Default, result_file = nil, config_path = nil)
      linter = Jshint::Lint.new(config_path)
      linter.lint
      reporter = Jshint::Reporters.const_get(reporter_name).new(linter.errors)

      printer = lambda do |stream|
        stream.puts reporter.report
      end

      if result_file
        Dir.mkdir(File.dirname(result_file))
        File.open(result_file, 'w') do |stream|
          printer.call(stream)
        end
      else
        printer.call($stdout)
      end

      linter
    end
  end
end
