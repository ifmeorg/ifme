# frozen_string_literal: true

include CloudinaryHelper

class ProfilePicture
  DEFAULT_AVATAR = '/assets/default_ifme_avatar.png'
  # Future task: Optimize Cloudinary image size based on responsive layout
  DEFAULT_SIZE = 150
  # JavaScript that allows image to fallback if main src URL cannot load
  DEFAULT_AVATAR_JS = "this.onerror=null;this.src='#{DEFAULT_AVATAR}'"

  class << self
    # If the image is from Cloudinary, use cl_image_tag
    # Otherwise, in production, use Cloudinary remote fetching
    # to grab the image from the if-me.org domain.
    # In development environment, don't use Cloudinary remote fetching.
    def fetch(path, class_name)
      html = if cloudinary(path)
               cl_img(get_cloudinary_image_id(path), true, class_name)
             elsif path.present? && Rails.env.production?
               cl_img(full_url(path), false, class_name)
             else
               html_img(path, class_name)
             end
      html.html_safe
    end

    private

    def cloudinary(path)
      path&.include?('.cloudinary.com')
    end

    def get_cloudinary_image_id(path)
      path.split('/').last.split('.').first
    end

    def full_url(path)
      "#{Rails.application.config.action_controller.asset_protocol}://"\
      "#{Rails.application.config.action_controller.asset_host}#{path}"
    end

    def cl_img(id_or_url, is_image_id, class_name)
      cl_image_tag(
        id_or_url,
        type: is_image_id ? 'upload' : 'fetch', format: 'jpg',
        quality: 'auto:good', width: DEFAULT_SIZE, height: DEFAULT_SIZE,
        crop: 'fill', dpr: 'auto', client_hints: true, class: class_name,
        onerror: DEFAULT_AVATAR_JS
      )
    end

    def html_img(path, class_name)
      "<img src='#{path}' class='#{class_name}'
        onerror=\"#{DEFAULT_AVATAR_JS}\" />"
    end
  end
end
