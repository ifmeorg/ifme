module RailsServeStaticAssets
  class Railtie < Rails::Railtie
    config.before_initialize do
      version = Rails.version
      if version >= "5.0.0"
        ::Rails.configuration.public_file_server.enabled = true
      elsif version >= "4.2.0"
        ::Rails.configuration.serve_static_files = true
      else
        ::Rails.configuration.serve_static_assets = true
      end
      ::Rails.configuration.action_dispatch.x_sendfile_header = nil
    end
  end
end
