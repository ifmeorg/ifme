# frozen_string_literal: true

class SessionsController < Devise::SessionsController
  prepend_before_action :check_recaptcha, only: [:create]
  prepend_before_action :display_recaptcha, only: [:new]

  def create
    super
    set_user_locale if user_signed_in?
  end

  private

  def set_user_locale
    current_user.update(locale: cookies[:locale]) unless default_locale?
  end

  def default_locale?
    cookies[:locale].eql?(I18n.default_locale)
  end

  def check_recaptcha
    if(recaptcha_needed && !verify_recaptcha)
      self.resource = resource_class.new sign_in_params
      redirect_to new_session_path(resource_name, email: sign_in_params[:email])
    end
  end

  def display_recaptcha
    @display_captcha = recaptcha_needed
  end

  def recaptcha_needed
    user = User.find_by(email: sign_in_params[:email] || params[:email])
    failed_attempts = user&.failed_attempts.to_i
    failed_attempts >= 3
  end
end
