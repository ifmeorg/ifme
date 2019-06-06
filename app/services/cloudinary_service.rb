# frozen_string_literal: true
include CloudinaryHelper
include ReactOnRailsHelper

class CloudinaryService
  class << self
    def upload(file, options = {})
      Cloudinary::Uploader.upload(file, options)
    rescue StandardError => error
      puts error
    end

    def delete(public_id, options = {})
      Cloudinary::Uploader.destroy(public_id, options)
    rescue StandardError => error
      puts error
    end
  end
end
