module CompassRails
  module Test
    class RailsProject
      include FileHelper
      include DebugHelper
      include CommandHelper
      include RailsHelpers
      include Kernal::Captures

      APPLICATION_FILE = 'config/application.rb'

      attr_reader :directory, :version

      def initialize(directory, version)
        @directory = Pathname.new(directory)
        @version = version
        disable_cookies! if version == '3.1'
      end

      ## FILE METHODS

      def to_s
        directory_name
      end

      def directory_name
        File.basename(directory)
      end

      def file(path)
        directory.join(path)
      end

      # RAILS METHODS

      def boots?
        rails_property("compass.project_type") == "rails"
      end

      def precompile!
        run_command("rake assets:precompile", GEMFILES[version])
      end

      def setup_asset_fixtures!
        rm_rf file("app/assets")
        cp_r CompassRails::Test.root.join('test', 'fixtures', 'assets'), file("app")
      end

      def precompiled?(path)
        !Dir[asset_path(path)].empty?
      end

      def compiled_stylesheet(path, &block)
        File.open(asset_path(path)).read.tap do |css|
          debug(css)
          yield css if block_given?
        end
      end

      def asset_path(path_pattern)
        Dir[file(path_pattern)].first.tap do |asset|
          raise 'Asset not found' if asset.nil?
        end
      end

      def rails_property(key)
        rails_command(['runner', "'puts Rails.application.config.#{key}'"]).chomp
      end

      def set_rails(property, value)
        value = "\n    config.#{property} = #{value.inspect}\n"
        inject_into_file(directory.join(APPLICATION_FILE), value, :after, 'class Application < Rails::Application')
      end

      def disable_cookies!
        value = "\n    config.middleware.delete 'ActionDispatch::Session::CookieStore'\n"
        inject_into_file(directory.join(APPLICATION_FILE), value, :after, 'class Application < Rails::Application')
      end

    end
  end
end
