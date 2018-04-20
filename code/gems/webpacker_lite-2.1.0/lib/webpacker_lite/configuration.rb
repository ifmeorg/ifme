# Loads webpacker configuration from config/webpack/paths.yml
require "webpacker_lite/file_loader"
require "webpacker_lite/env"

class WebpackerLite::Configuration < WebpackerLite::FileLoader
  RAILS_WEB_PUBLIC = "public"

  class << self
    def manifest_path
      Rails.root.join(webpack_public_output_dir,
                      configuration.fetch(:manifest, "manifest.json"))
    end

    def webpack_public_output_dir
      Rails.root.join(RAILS_WEB_PUBLIC, configuration.fetch(:webpack_public_output_dir, "webpack"))
    end

    def base_path
      "/#{configuration.fetch(:webpack_public_output_dir, "webpack")}"
    end

    # Uses the hot_reloading_host if appropriate
    def base_url
      if WebpackerLite::Env.hot_loading?
        host = configuration[:hot_reloading_host]
        if host.blank?
          raise "WebpackerLite's /config/webpacker_lite.yml needs a configuration value for the "\
            "`hot_reloading_host` for environment #{Rails.env}."
        end
        if host.starts_with?("http")
          host
        else
          "http://#{host}"
        end
      else
        base_path
      end
    end

    def configuration
      load_instance
      raise WebpackerLite::FileLoader::FileLoaderError.new("WebpackerLite::Configuration.load_instance must be called first") unless instance
      instance.data
    end

    def file_path
      Rails.root.join("config", "webpacker_lite.yml")
    end
  end

  private
    def load_data
      return super unless File.exist?(@path)
      HashWithIndifferentAccess.new(YAML.load(File.read(@path))[WebpackerLite::Env.current])
    end
end
