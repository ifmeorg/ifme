# frozen_string_literal: true
include CloudinaryHelper
include ReactOnRailsHelper

class CloudinaryService

  class << self
    def upload(file, options = {})
      # to do: add exception handling
      begin
        Cloudinary::Uploader.upload(file, options)        
      rescue => exception
        nil
      end
    end

    def delete(public_id, options = {})
      begin
        Cloudinary::Uploader.destroy(public_id, options)
      rescue => exception
        nil
      end
    end
  end
end
