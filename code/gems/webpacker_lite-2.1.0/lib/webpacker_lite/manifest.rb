# Singleton registry for accessing the output path using generated manifest.
# This allows javascript_pack_tag, stylesheet_pack_tag, asset_pack_path to take a reference to,
# say, "calendar.js" or "calendar.css" and turn it into "/public/webpack/calendar.js" or
# "/public/webpack/calendar.css" in development. In production mode, it returns compiles
# files, # "/public/webpack/calendar-1016838bab065ae1e314.js" and
# "/webpack/calendar-1016838bab065ae1e314.css" for long-term caching

require "webpacker_lite/file_loader"
require "webpacker_lite/env"
require "webpacker_lite/configuration"

class WebpackerLite::Manifest < WebpackerLite::FileLoader
  class << self
    # Helper method to determine if the manifest file exists.
    def exist?
      path_object = WebpackerLite::Configuration.manifest_path
      path_object.exist?
    end

    def file_path
      WebpackerLite::Configuration.manifest_path
    end

    def missing_file_from_manifest_error(bundle_name)
      msg = <<-MSG
        WebpackerLite can't find #{bundle_name} in your manifest #{file_path}. Possible causes:
          1. You are hot reloading.
          2. Webpack has not re-run to reflect updates.
          3. You have misconfigured WebpackerLite's config/webpacker_lite.yml file.
          4. Your Webpack configuration is not creating a manifest.
      MSG
      raise(WebpackerLite::FileLoader::NotFoundError.new(msg))
    end

    # Same as lookup, but raises an error.
    def lookup!(name)
      lookup(name) || missing_file_from_manifest_error(name)
    end

    # Find the real file name from the manifest key.
    def lookup(name)
      instance.confirm_manifest_exists

      load_instance
      raise WebpackerLite::FileLoader::FileLoaderError.new("WebpackerLite::Manifest.load must be called first") unless instance
      instance.data[name.to_s]
    end
  end

  def confirm_manifest_exists
    raise missing_manifest_file_error(@path) unless File.exist?(@path)
  end

  private

    def missing_manifest_file_error(path_object)
      msg = <<-MSG

        WebpackerLite can't find the manifest file: #{path_object}
        Possible causes:
          1. You have not invoked webpack.
          2. You have misconfigured WebpackerLite's config/webpacker_lite.yml file.
          3. Your Webpack configuration is not creating a manifest.
    MSG
      raise(WebpackerLite::FileLoader::NotFoundError.new(msg))
    end

    def load_data
      return super unless File.exist?(@path)
      JSON.parse(File.read(@path))
    end
end
