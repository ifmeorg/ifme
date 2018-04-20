module CompassRails
  module Configuration
    def default_images_dir
      File.join("app", "assets", "images")
    end

    def default_fonts_dir
      File.join("app", "assets", "fonts")
    end

    def default_javascripts_dir
      File.join("app", "assets", "javascripts")
    end

    def default_css_dir
      File.join('public', CompassRails.prefix)
    end

    def default_http_path
      File.join(CompassRails.prefix)
    end

    def default_http_images_path
      "#{top_level.http_path}"
    end

    def default_http_javascripts_path
      "#{top_level.http_path}"
    end

    def default_http_fonts_path
      "#{top_level.http_path}"
    end

    def default_http_stylesheets_path
      "#{top_level.http_path}"
    end

    def default_preferred_syntax
      ::Rails.application.config.sass.preferred_syntax rescue nil
    end

    def default_sprite_load_path
      CompassRails.sprockets.paths
    end

    def project_type_without_default
      :rails
    end

    def default_sass_dir
      File.join("app", "assets", "stylesheets")
    end

    def default_http_generated_images_path
      # Relies on the fact that this will be loaded after the "normal"
      # defaults, so that method_missing finds http_root_relative
      http_root_relative "images"
    end

    def default_extensions_dir
      File.join("vendor", "plugins", "compass_extensions")
    end

    def default_cache_dir
      File.join("tmp", "sass-cache")
    end

    def default_project_path
      Rails.root
    end

    def default_environment
      Rails.env
    end
  end
end