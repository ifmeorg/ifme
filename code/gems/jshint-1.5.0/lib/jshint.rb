require "jshint/version"
require "jshint/railtie" if defined?(Rails)

# Our gems top level namespace
module Jshint
  autoload :Lint, 'jshint/lint'
  autoload :Configuration, 'jshint/configuration'

  # The absolute path to this gems root
  #
  # @return [String] The absolute path
  def self.root
    File.expand_path('../..', __FILE__)
  end
end
