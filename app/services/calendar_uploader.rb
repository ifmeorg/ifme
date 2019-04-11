# frozen_string_literal: true

class CalendarUploader
  require 'google/apis/calendar_v3'
  require 'access_token'

  attr_accessor :calendar_service # For using in tests

  def initialize(access_token)
    @calendar_service = Google::Apis::CalendarV3::CalendarService.new
    @calendar_service.authorization = AccessToken.new(access_token)
  end

  def upload_event(summary, date)
    parsed_date = date.to_time.iso8601

    event = { summary: summary,
              start: { date_time: parsed_date },
              end: { date_time: parsed_date } }

    @calendar_service.insert_event('primary', event, send_notifications: true)
  end

  def delete_event(event_id)
    @calendar_service.delete_event('primary', event_id)
  end
end
