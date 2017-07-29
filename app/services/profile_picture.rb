# frozen_string_literal: true

class ProfilePicture
  DEFAULT_AVATAR = '/assets/default_ifme_avatar.png'

  class << self
    def fetch(avatar, class_name)
      html = "<div class='#{class_name}' " \
             "style='background: url(#{avatar_url(avatar)})'></div>"
      html.html_safe
    end

    private

    def avatar_url(avatar)
      if avatar.blank?
        DEFAULT_AVATAR
      elsif avatar.include?('/assets/contributors/')
        avatar
      else
        response = Net::HTTP.get_response(URI.parse(avatar))
        valid_response?(response) ? avatar : DEFAULT_AVATAR
      end
    end

    def valid_response?(response)
      response.code.to_f >= 200 && response.code.to_f < 400
    end
  end
end
