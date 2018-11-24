# frozen_string_literal: true

class CalendarUploader
  require 'google/apis/calendar_v3'
  require 'access_token'

  attr_reader :summary, :date, :access_token, :email

  def initialize(summary:,
                 date:,
                 access_token:,
                 email:,
                 service: Google::Apis::CalendarV3::CalendarService.new)

    @summary = summary
    @date = date
    @access_token = access_token
    @email = email

    @calendar_service = service
    @calendar_service.authorization = AccessToken.new(@access_token)
  end

  def upload_event
    parsed_date = date.to_time.iso8601

    event = {
      summary: summary,
      start: { date_time: parsed_date },
      end: { date_time: parsed_date }
    }

    @calendar_service.insert_event('primary', event, send_notifications: true)
  end
end
