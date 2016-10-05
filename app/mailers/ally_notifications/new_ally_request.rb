module AllyNotifications
  class NewAllyRequest
    include Rails.application.routes.url_helpers

    def initialize(recipient, data, allies_url)
      @recipient  = recipient
      @data       = data
      @allies_url = allies_url
    end

    def to
      @recipient.email
    end

    def subject
      I18n.t('mailers.new_ally_request.subject', ally_name: @data[:user])
    end

    def message
      I18n.t('mailers.new_ally_request.message', allies_url: @allies_url)
    end
  end
end

