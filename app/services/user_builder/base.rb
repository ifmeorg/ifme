# frozen_string_literal: true
module UserBuilder
  class Base
    def self.call(user:, auth:)
      new(user: user, auth: auth)
    end

    def initialize(user:, auth:)
      user.tap do
        user.provider = auth.provider
        user.name     = auth.info.name
        user.uid      = provider_uid(auth)
        user.email    = auth.info.email
        user.password = default_password
      end
    end

    private

    def default_password
      Devise.friendly_token[0, 20]
    end

    def provider_uid(auth)
      auth.provider + auth.uid
    end
  end
end
