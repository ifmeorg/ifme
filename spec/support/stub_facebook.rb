# frozen_string_literal: true

module StubFacebook
  def stub_env_for_omniauth_fb
    request.env['devise.mapping'] = Devise.mappings[:user]

    request.env['omniauth.auth'] = OmniAuth::AuthHash.new(
      provider: 'facebook',
      uid: '1234',
      info: {
        email: 'example@xyze.it',
        name: 'Test User',
        image: 'http://example.com/image.jpg'
      },
      credentials: {
        token: 'abcdefg12345',
        refresh_token: '12345abcdefg',
        expires_at: DateTime.now.in_time_zone
      }
    )
  end
end
