module CompassRails
  class Railtie < Rails::Railtie

    initializer "compass.initialize_rails", :group => :all do |app|
      require 'compass'
      require 'compass-rails/patches/3_1'
      Compass.discover_extensions!
      CompassRails.configure_rails!(app)
    end

    config.compass = begin
      @compass ||= begin
        data = if (config_file = Compass.detect_configuration_file) && (config_data = Compass.configuration_for(config_file))
          config_data
        else
          Compass::Configuration::Data.new("rails_config")
        end
        data.project_type = :rails # Forcing this makes sure all the rails defaults will be loaded.
        Compass.add_configuration(:rails)
        Compass.add_configuration(data)
        Compass.configuration.on_sprite_saved do |filename|
          if Rails.application.config.assets.digest && # if digesting is enabled
              caller.grep(/static_compiler/).any? && #OMG HAX - check if we're being precompiled
              Compass.configuration.generated_images_path[Compass.configuration.images_path] # if the generated images path is not in the assets images directory, we don't have to do these backflips

            # Clear entries in Hike::Index for this sprite's directory.
            # This makes sure the asset can be found by find_assets
            CompassRails.sprockets.send(:trail).instance_variable_get(:@entries).delete(File.dirname(filename))

            pathname      = Pathname.new(filename)
            logical_path  = pathname.relative_path_from(Pathname.new(Compass.configuration.images_path))
            asset         = CompassRails.sprockets.find_asset(logical_path)
            target        = File.join(Rails.public_path, Rails.application.config.assets.prefix, asset.digest_path)

            # Adds the asset to the manifest file.
            Sprockets::StaticCompiler.generated_sprites[logical_path.to_s] = asset.digest_path

            # Adds the fingerprinted asset to the public directory
            FileUtils.mkdir_p File.dirname(target)
            asset.write_to target

          end
        end
        data
      end
    end
  end
end
