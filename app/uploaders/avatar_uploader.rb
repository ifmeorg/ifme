class AvatarUploader < CarrierWave::Uploader::Base
  include Cloudinary::CarrierWave

  # Provide a default URL as a default if there hasn't been a file uploaded:
  def default_url
    '/assets/default_ifme_avatar.png'
  end

  version :thumb do
    process resize_to_fit: [100, 100]
  end

  version :full do
    process resize_to_fit: [200, 200]
  end

  def extension_white_list
    %w(jpg jpeg gif png)
  end
end
