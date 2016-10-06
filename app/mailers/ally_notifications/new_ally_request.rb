# frozen_string_literal: true

module AllyNotifications
  # Class helper to build new ally request message
  class NewAllyRequest
    include ::UrlHelper

    def initialize(recipient, data)
      @recipient  = recipient
      @data       = data
    end

    def to
      @recipient.email
    end

    def subject
      I18n.t('mailers.new_ally_request.subject', ally_name: @data[:user])
    end

    def message
      I18n.t('mailers.new_ally_request.message', allies_url: allies_url)
    end
  end
end
