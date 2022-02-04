# frozen_string_literal: true

class SessionsController < Devise::SessionsController
  prepend_before_action :check_recaptcha, only: [:create]
  before_action :set_recaptcha, only: [:new]
  prepend_before_action :invalidate_all_sessions, only: [:destroy]

  def new
    super
  end

  def create
    super
    set_user_locale if user_signed_in?
  end

  def destroy
    super
  end

  private

  def set_user_locale
    current_user.update(locale: cookies[:locale]) unless default_locale?
  end

  def default_locale?
    cookies[:locale].eql?(I18n.default_locale)
  end

  def check_recaptcha
    if recaptcha_required_for_user? && !verify_recaptcha
      self.resource = resource_class.new sign_in_params
      redirect_to new_session_path(resource_name, recaptcha: true)
    else
      cookies.delete(:login_recaptcha)
    end
  end

  def set_recaptcha
    return unless show_recaptcha?

    @display_recaptcha = true
    cookies.permanent[:login_recaptcha] = true
  end

  def show_recaptcha?
    RecaptchaService.recaptcha_configured? &&
      (cookies[:login_recaptcha] ||
      params[:recaptcha] ||
      recaptcha_required_for_user?)
  end

  def recaptcha_required_for_user?
    user = User.find_by(email: sign_in_params[:email])
    return false if user.nil?

    RecaptchaService.new(user).recaptcha_required_for_login?
  end

  def invalidate_all_sessions
    current_user.invalidate_all_sessions!
  end
end
