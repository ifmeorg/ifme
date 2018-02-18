# frozen_string_literal: true

class OmniauthCallbacksController < Devise::OmniauthCallbacksController
  def google_oauth2
    if user
      authenticate_user(google, user)
    else
      redirect_to_new_session
    end
  end

  def facebook
    if user
      authenticate_user(:facebook, user)
    else
      redirect_to_new_session
    end
  end

  def user
    User.from_omniauth(request.env["omniauth.auth"])
  end

  def authenticate_user(provider, user)
    flash[:notice] = I18n.t('devise.omniauth_callbacks.success',
                            kind: t("omniauth.#{provider}"))
    sign_in_and_redirect user, event: :authentication
  end

  def redirect_to_new_session
    redirect_to new_user_session_path, notice: t('omniauth.access_denied')
  end
end
