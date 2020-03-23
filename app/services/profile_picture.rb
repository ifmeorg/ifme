# frozen_string_literal: true
include CloudinaryHelper
include ReactOnRailsHelper

class ProfilePicture
  # Future task: Optimize Cloudinary image size based on responsive layout
  DEFAULT_SIZE = 150

  class << self
    def fetch(path, options = {})
      alt = options[:alt] ||
            I18n.t('devise.registrations.edit.labels.profile_picture')
      react_component 'Avatar', props: {
        name: options[:name] || nil,
        src: normalize_url(path),
        small: options[:small] || nil,
        large: options[:large] || nil,
        alt: alt
      }
    end

    def normalize_url(path)
      # prod, uploaded to cloudinary
      if cloudinary_src path
        get_cloudinary_url(path, 'upload')
      # prod, remotely fetched by cloudinary
      elsif path.present? && Rails.env.production?
        get_cloudinary_url(path, 'fetch')
      # dev environment
      else
        path
      end
    end

    private

    def cloudinary_src(path)
      path&.include?('.cloudinary.com')
    end

    def get_cloudinary_image_id(path)
      path.split('/').last.split('.').first
    end

    def get_cloudinary_url(path, type)
      id_or_url = get_cloudinary_image_id(path)
      type == 'fetch' && id_or_url = get_local_url(path)
      cl_image_path(id_or_url, claudinary_params(type))
    end

    def claudinary_params(type)
      { type: type,
        format: 'jpg',
        quality: 'auto:good',
        width: DEFAULT_SIZE,
        height: DEFAULT_SIZE,
        crop: 'fill',
        dpr: 'auto',
        client_hints: true,
        sign_url: true }
    end

    def get_local_url(path)
      "#{Rails.application.config.force_ssl ? 'https' : 'http'}://"\
      "#{Rails.application.config.action_controller.asset_host}#{path}"
    end
  end
end
