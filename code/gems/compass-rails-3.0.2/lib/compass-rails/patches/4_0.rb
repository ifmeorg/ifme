require 'compass-rails/patches/compass'
require 'compass-rails/patches/sass_importer'
require 'compass-rails/patches/sprite_importer'

Compass::Core::SassExtensions::Functions::Urls::GeneratedImageUrl.module_eval do
  def generated_image_url(path, cache_buster = Sass::Script::Bool.new(false))
    cachebust_generated_images(path)
    asset_url(path)
  end

  def cachebust_generated_images(path)
    generated_images_dir = Compass.configuration.generated_images_dir
    generated_images_dir = Rails.root.join(generated_images_dir)

    sprockets_env = options[:sprockets][:environment]

    if sprockets_env.respond_to?(:trail, true)
      sprockets_trail = sprockets_env.send(:trail)
    else
      sprockets_trail = sprockets_env.index
    end

    sprockets_entries = sprockets_trail.instance_variable_get(:@entries) || {}
    sprockets_stats   = sprockets_trail.instance_variable_get(:@stats) || {}

    if sprockets_entries.key?(generated_images_dir.to_s)
      path = path.value
      dir  = File.dirname(path)

      # Delete the entries (directories) which cache the files/dirs in a directory
      entry = generated_images_dir.join(dir).to_s
      sprockets_entries.delete(entry)

      # Delete the stats (file/dir info) which cache the what kind of file/dir each image is
      stat = generated_images_dir.join(path).to_s
      sprockets_stats.delete(stat)
    end
  end
end
