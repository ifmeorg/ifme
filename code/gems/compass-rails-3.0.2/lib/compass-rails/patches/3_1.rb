require 'compass-rails/patches/compass'
require 'compass-rails/patches/static_compiler'

Compass::Core::SassExtensions::Functions::Urls::GeneratedImageUrl.module_eval do
  def generated_image_url(path, cache_buster = Sass::Script::Bool.new(false))
    asset_url(path, Sass::Script::String.new('image'))
  end
end
