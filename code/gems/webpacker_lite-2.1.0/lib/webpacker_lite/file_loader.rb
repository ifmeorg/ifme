# Provides a base singleton-configuration pattern for loading a JSON or YAML file, given a path
class WebpackerLite::FileLoader
  class NotFoundError < StandardError; end
  class FileLoaderError < StandardError; end

  class_attribute :instance
  attr_accessor :data, :mtime

  class << self
    def load_instance(path = file_path)
      # Assume production is 100% cached
      return if self.instance && # if we have a singleton
        (env == "production" || # skip if production bc always cached
          (File.exist?(path) && self.instance.mtime == File.mtime(path))) # skip if mtime not changed

      self.instance = new(path)
    end

    def file_path
      raise FileLoaderError.new("Subclass of WebpackerLite::FileLoader should override this method")
    end

    private

    # Prefer the NODE_ENV to the rails env.
    def env
      ENV["NODE_ENV"].presence || Rails.env
    end
  end

  private
    def initialize(path)
      @path = path
      @mtime = File.exist?(path) ? File.mtime(path) : nil
      @data = load_data
    end

    def load_data
      {}.freeze
    end
end
