module UserBuilder
  class Builder
    SERVICE = {
      # 'google_oauth' => GoogleOauth2
    }

    # UserBuilder::Builder.build(user: user, provider: provider, auth: auth)
    def self.build(user:, auth:)
      service = SERVICE.fetch(auth.provider, UserBuilder::Base)
      service.call(user: user, auth: auth)
    end
  end
end
