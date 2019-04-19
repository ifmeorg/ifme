# frozen_string_literal: true

module StubGoogleOauth2
  def stub_env_for_omniauth
    request.env['devise.mapping'] = Devise.mappings[:user]

    request.env['omniauth.auth'] = OmniAuth::AuthHash.new(
      provider: 'google_oauth2',
      uid: '1234',
      info: {
        email: 'example@xyze.it',
        name: 'Test User',
        image: '...'
      },
      credentials: {
        token: 'abcdefg12345',
        refresh_token: '12345abcdefg',
        expires_at: DateTime.now.in_time_zone
      }
    )
  end
end
