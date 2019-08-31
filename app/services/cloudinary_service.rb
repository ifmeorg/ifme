# frozen_string_literal: true
include CloudinaryHelper
include ReactOnRailsHelper

# INFO: Uplaods, gets and deletes images expoiting the cloudinary api.
# USAGE:
#   - upload:
#       - It takes an image/file as a parameter,
#       - It returns a Hash. Its recomended is to save the images ["public_id"]
#   - fetch:
#       - It takes a "public_id" as a parameter.
#       - It returns the secure url of the image.
#   - delete:
#       - It takes a "public_id" as a parameter.
#       - It returns a Hash with the status of the delete.
# TODO: better exception handling. and error reporting
class CloudinaryService
  class << self
    def upload(file, options = {})
      Cloudinary::Uploader.upload(file, options)
    rescue StandardError
      nil
    end

    def fetch(public_id)
      ENV['CLOUDINARY_SECURE_URL'] + public_id
    end

    def delete(public_id, options = {})
      Cloudinary::Uploader.destroy(public_id, options)
    rescue StandardError
      nil
    end
  end
end
