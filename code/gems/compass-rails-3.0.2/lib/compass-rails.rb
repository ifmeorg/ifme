require 'compass'
require "compass-rails/version"
require "compass-rails/configuration"

module CompassRails

    RAILS_32 = %r{^3.2}
    RAILS_31 = %r{^3.1}

    extend self

    def setup_fake_rails_env_paths(sprockets_env)
      return unless rails_loaded?

      if sprockets_env.respond_to?(:trail, true)
        sprockets_trail = sprockets_env.send(:trail)
      else
        sprockets_trail = sprockets_env.index
      end

      keys = ['app/assets', 'lib/assets', 'vendor/assets']
      local = keys.map {|path| ::Rails.root.join(path) }.map { |path| [File.join(path, 'images'), File.join(path, 'stylesheets')] }.flatten!
      sprockets_trail.paths.unshift(*local)
      paths = []
      ::Rails::Engine.subclasses.each do |subclass|
        paths = subclass.paths
        keys.each do |key|
          sprockets_trail.paths.unshift(*paths[key].existent_directories)
        end
      end
    end

    def sass_config
      ::Rails.application.config.sass
    end

    def sprockets
      @sprockets ||= Rails.application.assets || ::Sprockets::Railtie.build_environment(Rails.application)
    end

    def context
      @context ||= begin
        sprockets.version = ::Rails.env + "-#{sprockets.version}"
        setup_fake_rails_env_paths(sprockets)
        context = ::CompassRails.sprockets.context_class
        context.extend(::Sprockets::Helpers::IsolatedHelper)
        context.extend(::Sprockets::Helpers::RailsHelper)
        context.extend(::Sass::Rails::Railtie::SassContext)
        context.sass_config = sass_config

        context
      end
    end

    def rails_loaded?
      defined?(::Rails)
    end

    def rails_version
      rails_spec = (Gem.loaded_specs["railties"] || Gem.loaded_specs["rails"])
      raise "You have to require Rails before compass" unless rails_spec
      rails_spec.version.to_s
    end

    def rails31?
      return false unless defined?(::Rails)
      version_match RAILS_31
    end

    def rails32?
      return false unless defined?(::Rails)
      version_match RAILS_32
    end

    def version_match(version)
      !(rails_version =~ version).nil?
    end

    def configuration
      config = Compass::Configuration::Data.new('rails')
      config.extend(CompassRails::Configuration)
      config
    end

    def prefix
      ::Rails.application.config.assets.prefix
    end

    def configure_rails!(app)
      return unless app.config.respond_to?(:sass)
      sass_config = app.config.sass
      compass_config = app.config.compass

      sass_config.load_paths.concat(compass_config.sass_load_paths)

      { :output_style => :style,
        :line_comments => :line_comments,
        :cache => :cache,
        :disable_warnings => :quiet,
        :preferred_syntax => :preferred_syntax
      }.each do |compass_option, sass_option|
        set_maybe sass_config, compass_config, sass_option, compass_option
      end
      if compass_config.sass_options
        compass_config.sass_options.each do |config, value|
          sass_config.send("#{config}=", value)
        end
      end
    end

  private

    # sets the sass config value only if the corresponding compass-based setting
    # has been explicitly set by the user.
    def set_maybe(sass_config, compass_config, sass_option, compass_option)
      if compass_value = compass_config.send(:"#{compass_option}_without_default")
        sass_config.send(:"#{sass_option}=", compass_value)
      end
    end

end

if defined?(::Rails)
  Compass::AppIntegration.register(:rails, "::CompassRails")
  require "compass-rails/patches"
  require "compass-rails/railties"
end
