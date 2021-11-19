# frozen_string_literal: true

class OmniauthCallbacksController < Devise::OmniauthCallbacksController
  def google_oauth2
    omniauth_login
  end

  def facebook
    omniauth_login
  end

  def omniauth_login
    if user.blank?
      redirect_to(new_user_session_path, notice:
        t('omniauth.access_denied')) && return
    end

    user.accept_invitation! if invitation_token
    upload_avatar(omniauth_avatar)
    flash[:notice] = I18n.t('devise.omniauth_callbacks.success',
                            kind: t("navigation.#{provider_key}"))
    sign_in_and_redirect @user, event: :authentication
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

  def invitation_token
    # Returns the invitation token passed in with the callback url
    request.env.dig('omniauth.params', 'invitation_token')
  end

  def upload_avatar(omniauth_avatar)
    return unless update_needed?(omniauth_avatar)

    user.third_party_avatar = omniauth_avatar
    user.remote_avatar_url = omniauth_avatar
    user.save!
  end

  def provider_key
    return 'google' if @user.provider == 'google_oauth2'

    @user.provider
  end
end
