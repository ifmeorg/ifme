# frozen_string_literal: true

module AllyNotifications
  # Class helper to build accepted ally request message
  class AcceptedAllyRequest
    def initialize(recipient, data)
      @recipient = recipient
      @data      = data
    end

    def to
      @recipient.email
    end

    def subject
      I18n.t('mailers.accepted_ally_request.subject', ally_name: @data[:user])
    end

    def message
      I18n.t('mailers.accepted_ally_request.message', ally_name: @data[:user])
    end
  end
end
