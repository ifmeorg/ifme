# frozen_string_literal: true

class CalendarUploader
  require 'google/apis/calendar_v3'
  require 'access_token'

  attr_reader :summary, :date, :access_token, :email, :calendar_id, :event_id

  def initialize(summary:,
                 date:,
                 access_token:,
                 email:,
                 service: Google::Apis::CalendarV3::CalendarService.new,
                 calendar_id: 'primary',
                 event_id: nil
                )
   

    @summary = summary
    @date = date
    @access_token = access_token
    @email = email
    @calendar_id = calendar_id
    @event_id = event_id
    @calendar_service = service
    @calendar_service.authorization = AccessToken.new(@access_token)
  end
  def upload_event
    parsed_date = Chronic.parse(date, endian_precedence: %i[little median])
                         .to_time.iso8601
    event = {
      summary: summary,
      start: { date_time: parsed_date },
      end: { date_time: parsed_date }
    }
    @calendar_service.insert_event(calendar_id, event, send_notifications: true)
  end
  
  def get_event
    @calendar_service.get_event(calendar_id,event_id)
  end
  def delete_event
    @calendar_service.delete_event(calendar_id,event_id)
  end
end
