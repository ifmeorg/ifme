module WebpackerLite
  def self.bootstrap
    WebpackerLite::Env.load_instance
    WebpackerLite::Configuration.load_instance
    WebpackerLite::Manifest.load_instance
  end

  def env
    WebpackerLite::Env.current.inquiry
  end
end

require "webpacker_lite/railtie" if defined?(Rails)
