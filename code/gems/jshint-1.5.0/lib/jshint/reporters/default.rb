module Jshint::Reporters
  # Outputs a basic lint report suitable for STDOUT
  class Default

    # @return [String] the report output
    attr_reader :output

    # Sets up the output string for the final report
    #
    # @param results [Hash] Key value pairs containing the filename and associated errors
    def initialize(results = {})
      @results = results
      @output = ''
    end

    # Loops through all the errors and generates the report
    #
    # @example
    #   foo/bar/baz.js: line 4, col 46, Bad operand.
    #   foo/bar/baz.js: line 39, col 7, Missing semicolon.
    #
    #   2 errors
    #
    # @return [String] The default report
    def report
      len = 0
      @results.each do |file, errors|
        len += errors.length
        print_errors_for_file(file, errors)
      end
      if output
        print_footer(len)
        output
      end
    end

    # Appends new error strings to the Report output
    #
    # @example
    #   foo/bar/baz.js: line 4, col 46, Bad operand.
    #   foo/bar/baz.js: line 39, col 7, Missing semicolon.
    #
    # @param file [String] The filename containing the errors
    # @param errors [Array] The errors for the file
    # @return [void]
    def print_errors_for_file(file, errors)
      errors.map do |error|
        output << "#{file}: line #{error['line']}, col #{error['character']}, #{error['reason']}\n" unless error.nil?
      end
    end

    # Appends a footer summary to the Report output
    #
    # @example
    #   1 error
    #   3 errors
    #
    # @param len [Fixnum] The number of errors in this Report
    # @return [void]
    def print_footer(len)
      output << "\n#{len} error#{len === 1 ? nil : 's'}"
    end
  end
end
