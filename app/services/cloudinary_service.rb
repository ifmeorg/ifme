# frozen_string_literal: true
include CloudinaryHelper
include ReactOnRailsHelper

class CloudinaryService
  class << self
    def upload(file, options = {})
      # to do: add exception handling
      Cloudinary::Uploader.upload(file, options)
    end

    def delete(public_id, options = {})
      # to do: add exception handling
      Cloudinary::Uploader.destroy(public_id, options)
    end
  end
end
