require "execjs"
require "multi_json"
require "jshint/configuration"

module Jshint
  # Performs the linting of the files declared in our Configuration object
  class Lint

    # @return [Hash] A Hash of errors
    attr_reader :errors

    # @return [Jshint::Configuration] The configuration object
    attr_reader :config

    # Sets up our Linting behaviour
    #
    # @param config_path [String] The absolute path to a configuration YAML file
    # @return [void]
    def initialize(config_path = nil)
      @config = Configuration.new(config_path)
      @errors = {}
    end

    # Runs JSHint over each file in our search path
    #
    # @return [void]
    def lint
      config.javascript_files.each do |file|
        file_content = get_file_content_as_json(file)
        code = %(
          JSHINT(#{file_content}, #{jshint_options}, #{jshint_globals});
          return JSHINT.errors;
        )
        errors[file] = context.exec(code)
      end
    end

    # Converts a Hash in to properly escaped JSON
    #
    # @param hash [Hash]
    # @return [String] The JSON outout
    def get_json(hash)
      MultiJson.dump(hash)
    end

    private

    def get_file_content(path)
      File.open(path, "r:UTF-8").read
    end

    def get_file_content_as_json(path)
      content = get_file_content(path)
      get_json(content)
    end

    def jshint_globals
      @jshint_globals ||= get_json(config.global_variables)
    end

    def jshint_options
      @jshint_options ||= get_json(config.lint_options)
    end

    def jshint_path
      File.join(Jshint.root, 'vendor', 'assets', 'javascripts', 'jshint.js')
    end

    def jshint
      @jshint ||= get_file_content(jshint_path)
    end

    def context
      @context ||= ExecJS.compile("var window = {};\n" + jshint)
    end
  end
end
