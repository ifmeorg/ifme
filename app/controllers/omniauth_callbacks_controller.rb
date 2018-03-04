# frozen_string_literal: true

class OmniauthCallbacksController < Devise::OmniauthCallbacksController
  # rubocop:disable MethodLength
  def google_oauth2
    @user = User.find_for_google_oauth2(
      request.env['omniauth.auth'],
      current_user
    )

    if @user
      flash[:notice] = I18n.t('devise.omniauth_callbacks.success',
                              kind: t('omniauth.google'))
      sign_in_and_redirect @user, event: :authentication
    else
      redirect_to new_user_session_path, notice: t('omniauth.access_denied')
    end
  end
  # rubocop:enable MethodLength
end
