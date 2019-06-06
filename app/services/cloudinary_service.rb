# frozen_string_literal: true
include CloudinaryHelper
include ReactOnRailsHelper

# TODO: better exception handling. and error reporting
class CloudinaryService
  class << self
    def upload(file, options = {})
      Cloudinary::Uploader.upload(file, options)
    rescue StandardError
      nil
    end

    def delete(public_id, options = {})
      Cloudinary::Uploader.destroy(public_id, options)
    rescue StandardError
      nil
    end
  end
end
