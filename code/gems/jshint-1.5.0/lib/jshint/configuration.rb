require 'yaml'

module Jshint
  # Configuration object containing JSHint lint settings
  class Configuration

    # @return [Hash] the configration options
    attr_reader :options

    # Initializes our configuration object
    #
    # @param path [String] The path to the config file
    def initialize(path = nil)
      @path = path || default_config_path
      @options = parse_yaml_config
    end

    # Returns the value of the options Hash if one exists
    #
    # @param key [Symbol]
    # @return The value of the of the options Hash at the passed in key
    def [](key)
      options["options"][key.to_s]
    end

    # Returns a Hash of global variables if one exists
    #
    # @example
    #   {
    #     "$" => true,
    #     jQuery => true,
    #     angular => true
    #   }
    #
    # @return [Hash, nil] The key value pairs or nil
    def global_variables
      options["options"]["globals"]
    end

    # Returns a Hash of options to be used by JSHint
    #
    # See http://jshint.com/docs/options/ for more config options
    #
    # @example
    #   {
    #     "eqeqeq" => true,
    #     "indent" => 2
    #   }
    # @return [Hash, nil] The key value pairs of options or nil
    def lint_options
      @lint_options ||= options["options"].reject { |key| key == "globals" }
    end

    # Returns the list of files that JSHint should lint over relatives to the Application root
    #
    # @example
    #   [
    #     'angular/controllers/*.js',
    #     'angular/services/*.js'
    #   ]
    #
    # @return [Array<String>] An Array of String files paths
    def files
      options.fetch("files", [])
    end

    def exclude_files
      options.fetch("exclude_files", [])
    end

    def exclude_paths
      options.fetch("exclude_paths", [])
    end

    def include_paths
      options.fetch("include_paths", [])
    end

    def search_paths
      default_search_paths + include_paths
    end

    def default_search_paths
      [
        'app/assets/javascripts',
        'vendor/assets/javascripts',
        'lib/assets/javascripts'
      ]
    end

    def javascript_files
      get_files(search_paths, files) - get_files(exclude_paths, files) - get_files(search_paths, exclude_files)
    end

    private

    def read_config_file
      @read_config_file ||= File.open(@path, 'r:UTF-8').read
    end

    def parse_yaml_config
      YAML.load(read_config_file)
    end

    def default_config_path
      File.join(defined?(Rails) ? Rails.root : Dir.pwd, 'config', 'jshint.yml')
    end

    def get_files paths, files
      paths.map{ |path| files.map{ |file| Dir.glob(File.join(path, file)) }}.flatten
    end
  end
end
