require 'google/api_client'

class CalendarUploader
  attr_reader :summary, :date, :access_token, :email

  def initialize(summary:, date:, access_token:, email:)
    @summary = summary
    @date = date
    @access_token = access_token
    @email = email
  end

  def upload_event
    client.authorization.access_token = access_token

    service = client.discovered_api('calendar', 'v3')
    parsed_date = Chronic.parse(date, endian_precedence: [:little, :median]).to_time.iso8601

    event = {
      'summary' => summary,
      'start' => { 'dateTime' => parsed_date },
      'end' => { 'dateTime' => parsed_date }
    }

    params = {
      api_method: service.events.insert,
      parameters:         { 'calendarId' => email, 'sendNotifications' => true },
      body: JSON.dump(event),
      headers:         { 'Content-Type' => 'application/json' }
    }

    client.execute!(params)
  end

  def client
    @client ||= Google::APIClient.new(application_name: ENV['GOOGLE_APP_NAME'])
  end
end
