module CompassRails
  module Test
    module RailsHelpers
      include FileHelper
      include DebugHelper
      include CommandHelper
        RAILS_5_0   = "5.0"
        RAILS_4_2   = "4.2"
        RAILS_4_0   = "4.0"
        RAILS_3_2   = "3.2"
        RAILS_3_1   = "3.1"

        WORKING_DIR = File.join(ROOT_PATH, 'rails-temp')

        VERSION_LOOKUP = {
          RAILS_5_0 => %r{^5\.0\.},
          RAILS_4_2 => %r{^4\.2\.},
          RAILS_4_0 => %r{^4\.0\.},
          RAILS_3_2 => %r{^3\.2\.},
          RAILS_3_1 => %r{^3\.1\.},
        }

        GEMFILES = {
          RAILS_5_0 => GEMFILES_DIR.join("rails50.gemfile").to_s,
          RAILS_4_2 => GEMFILES_DIR.join("rails42.gemfile").to_s,
          RAILS_4_0 => GEMFILES_DIR.join("rails40.gemfile").to_s,
          RAILS_3_2 => GEMFILES_DIR.join("rails32.gemfile").to_s,
          RAILS_3_1 => GEMFILES_DIR.join("rails31.gemfile").to_s
        }

        GENERATOR_OPTIONS = ['-q', '-G', '-O', '--skip-bundle']

      def rails_command(options)
        debug cmd = "rails #{options.join(' ')}"
        run_command(cmd, GEMFILES[rails_version])
      end

      def rails_version
        @rails_version ||= VERSION_LOOKUP.detect { |version, regex| CompassRails.version_match(regex) }.first
      end

      # Generate a rails application without polluting our current set of requires
      # with the rails libraries. This will allow testing against multiple versions of rails
      # by manipulating the load path.
      def generate_rails_app(name, options = [])
        options += GENERATOR_OPTIONS
        rails_command(['new', name, *options])
      end

      def within_rails_app(named, &block)
        dir = "#{named}-#{rails_version}"
        rm_rf File.join(WORKING_DIR, dir)
        mkdir_p WORKING_DIR
        cd(WORKING_DIR) do
          generate_rails_app(dir, [])
          cd(dir) do
            yield RailsProject.new(File.join(WORKING_DIR, dir), rails_version)
          end
        end
        rm_rf File.join(WORKING_DIR, dir) unless ENV['DEBUG_COMPILE']
      end

    end
  end
end
