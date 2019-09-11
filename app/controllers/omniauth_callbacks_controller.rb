# frozen_string_literal: true

class OmniauthCallbacksController < Devise::OmniauthCallbacksController
  def google_oauth2
    if user.present?
      user.accept_invitation! if invitation_token
      upload_avatar(google_avatar)

      flash[:notice] = I18n.t('devise.omniauth_callbacks.success',
                              kind: t('omniauth.google'))
      sign_in_and_redirect @user, event: :authentication
    else
      redirect_to new_user_session_path, notice: t('omniauth.access_denied')
    end
  end

  private

  def user
    @user ||= User.find_for_google_oauth2(request.env['omniauth.auth'])
  end

  def google_avatar
    request.env['omniauth.auth']&.[]('info')&.[]('image')
  end

  def update_needed?(google_avatar)
    return if google_avatar.nil?

    user.third_party_avatar != google_avatar
  end

  # returns the invitation token passed in with the callback url
  def invitation_token
    request.env.dig('omniauth.params', 'invitation_token')
  end

  def upload_avatar(google_avatar)
    return unless update_needed?(google_avatar)

    user.third_party_avatar = google_avatar
    user.remote_avatar_url = google_avatar
    user.save!
  end
end
