# frozen_string_literal: true
module UserBuilder
  class Builder
    # Adds new omni auth providers here
    SERVICE = {
      # 'google_oauth' => GoogleOauth2
    }.freeze

    # UserBuilder::Builder.build(user: user, provider: provider, auth: auth)
    def self.build(user:, auth:)
      service = SERVICE.fetch(auth.provider, UserBuilder::Base)
      service.call(user: user, auth: auth)
    end
  end
end
