Compass::Core::SassExtensions::Functions::ImageSize.class_eval do
  private

  def image_path_for_size(image_file)
    begin
      file = ::CompassRails.sprockets.find_asset(image_file)
      return (file.respond_to?(:pathname) ? file.pathname.to_s : file)
    rescue ::Sprockets::FileOutsidePaths
      return super(image_file)
    end
  end
end
