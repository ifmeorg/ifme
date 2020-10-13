# frozen_string_literal: true

module StubOmniauth
  def set_omniauth_auth_env(provider:, email:, token:)
    auth_hash = OmniAuth::AuthHash.new(
      provider: provider,
      uid: '1234',
      info: {
        email: email,
        name: 'Test User',
        image: 'http://example.com/image.jpg'
      },
      credentials: {
        token: token,
        refresh_token: '12345abcdefg',
        expires_at: DateTime.now.in_time_zone
      }
    )

    Rails.application.env_config['omniauth.auth'] = auth_hash
  end

  def set_devise_mapping_env
    Rails.application.env_config['devise.mapping'] = Devise.mappings[:user]
  end

  def set_invitation_token_env(invitee)
    Rails.application.env_config['omniauth.params'] = { 'invitation_token' => invitee.invitation_token }
  end

  def set_avatar_env(avatar_image_url)
    Rails.application.env_config['omniauth.auth']['info']['image'] = avatar_image_url
  end
end
