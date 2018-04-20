require 'appraisal'
require 'appraisal/command'
module Kernal
  module Captures
    def capture_output
      buffer = []
      real_stdout, $stdout = $stdout, StringIO.new
      buffer << yield
      buffer << $stdout.string
      return buffer.join
    ensure
      $stdout = real_stdout
    end

    def capture_all_output
      capture_output do
        capture_warning do
          yield
        end
      end
    end


    def capture_warning
      buffer = []
      real_stderr, $stderr = $stderr, StringIO.new
      buffer << yield
      buffer << $stderr.string
      return buffer.join
    ensure
      $stderr = real_stderr
    end
  end
end

include Kernal::Captures

module CompassRails
  module Test
    module CommandHelper
      include DebugHelper
      GEMFILES_DIR = Pathname.new(ROOT_PATH).join('gemfiles')
      BUNDLER_COMMAND = 'bundle'

      def run_command(command, gemfile=nil)
        debug "Running: #{command} with gemfile: #{gemfile}"
        capture_all_output { CompassRails::Test::CommandRunner.new(command, gemfile).run }
      end

      def bundle(gemfile=nil)
        run_command(BUNDLER_COMMAND, gemfile)
      end

    end
  end
end

# Executes commands with a clean environment
class CompassRails::Test::CommandRunner
  BUNDLER_ENV_VARS = %w(RUBYOPT BUNDLE_PATH BUNDLE_BIN_PATH BUNDLE_GEMFILE).freeze

  def self.from_args(gemfile)
    command = ([$0] + ARGV.slice(1, ARGV.size)).join(' ')
    new(command, gemfile)
  end

  def initialize(command, gemfile = nil)
    @original_env = {}
    @gemfile = gemfile
    if command =~ /^bundle/
      @command = command
    else
      @command = "bundle exec #{command}"
    end
  end

  def run
    with_clean_env { %x{#{@command}} }
  end

  def exec
    with_clean_env { Kernel.exec(@command) }
  end

  private

  def with_clean_env
    unset_bundler_env_vars
    ENV['BUNDLE_GEMFILE'] = @gemfile
    yield
  ensure
    restore_env
  end

  def unset_bundler_env_vars
    BUNDLER_ENV_VARS.each do |key|
      @original_env[key] = ENV[key]
      ENV[key] = nil
    end
  end

  def restore_env
    @original_env.each { |key, value| ENV[key] = value }
  end
end
