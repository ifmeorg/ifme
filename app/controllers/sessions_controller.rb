# frozen_string_literal: true

class SessionsController < Devise::SessionsController
  def create
    super
    set_user_locale if user_signed_in?
  end

  private

  def set_user_locale
    unless cookies[:locale].eql?(I18n.default_locale)
      current_user.update(locale: cookies[:locale])
    end
  end
end
