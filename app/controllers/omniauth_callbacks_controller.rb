# frozen_string_literal: true

class OmniauthCallbacksController < Devise::OmniauthCallbacksController
  def google_oauth2
    if user.present?
      user.accept_invitation! if invitation_token
      upload_avatar(omniauth_avatar)

      flash[:notice] = I18n.t('devise.omniauth_callbacks.success',
                              kind: t('omniauth.google'))
      sign_in_and_redirect @user, event: :authentication
    else
      redirect_to new_user_session_path, notice: t('omniauth.access_denied')
    end
  end

  def facebook
    if user.present?
      user.accept_invitation! if invitation_token
      upload_avatar(omniauth_avatar)
      flash[:notice] = I18n.t('devise.omniauth_callbacks.success',
                              kind: 'Facebook')
      sign_in_and_redirect @user, event: :authentication
    else
      redirect_to new_user_session_path, notice: t('omniauth.access_denied')
    end
  end

  private

  def user
    @user ||= User.find_for_oauth(request.env['omniauth.auth'])
  end

  def omniauth_avatar
    request.env['omniauth.auth']&.[]('info')&.[]('image')
  end

  def update_needed?(omniauth_avatar)
    return if omniauth_avatar.nil?

    user.third_party_avatar != omniauth_avatar
  end

  # returns the invitation token passed in with the callback url
  def invitation_token
    request.env.dig('omniauth.params', 'invitation_token')
  end

  def upload_avatar(omniauth_avatar)
    return unless update_needed?(omniauth_avatar)

    user.third_party_avatar = omniauth_avatar
    user.remote_avatar_url = omniauth_avatar
    user.save!
  end
end
