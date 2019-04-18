# frozen_string_literal: true
module Meetings
  class GoogleCalendarEventController < ApplicationController
    before_action :set_meeting
    before_action :set_meeting_member

    # POST /meetings/:meeting_id/google_calendar_event
    def create
      success, response = create_event

      if success && (event_id = response.try(:id))
        @meeting_member.update_column(:google_cal_event_id, event_id)
        redirect_to(group_path(@meeting.group_id),
                    notice: success_message(:create))
      else
        redirect_to(group_path(@meeting.group_id),
                    alert: error_message(:create, response))
      end
    end

    # DELETE /meetings/:meeting_id/google_calendar_event
    def destroy
      success, response = destroy_event

      if success && response
        @meeting_member.update_column(:google_cal_event_id, nil)
        redirect_to(group_path(@meeting.group_id),
                    notice: success_message(:destroy))
      else
        redirect_to(group_path(@meeting.group_id),
                    alert: error_message(:destroy, response))
      end
    end

    private

    def set_meeting
      @meeting = Meeting.friendly.find(params[:meeting_id])
      @meeting_member = @meeting.meeting_member(current_user)
    rescue ActiveRecord::RecordNotFound
      redirect_to_path(groups_path)
    end

    def set_meeting_member
      @meeting_member = @meeting.meeting_member(current_user)
    end

    def create_event
      uploader = CalendarUploader.new(current_user.google_access_token)
      rescue_google_calendar_ex do
        uploader.upload_event(@meeting.name, @meeting.date_time)
      end
    end

    def destroy_event
      uploader = CalendarUploader.new(current_user.google_access_token)
      rescue_google_calendar_ex do
        uploader.delete_event(@meeting_member.google_cal_event_id)
      end
    end

    def rescue_google_calendar_ex
      response = yield
      [true, response]
    rescue Google::Apis::ClientError => e
      [false, e.message]
    rescue Google::Apis::ServerError => e
      [false, e.message]
    end

    def success_message(action)
      t("meetings.google_cal.#{action}.success")
    end

    def error_message(action, exception_message)
      message = t("meetings.google_cal.#{action}.error")

      return message if exception_message.blank?

      message + ' ' + exception_message
    end
  end
end
