# frozen_string_literal: true
module Meetings
  class GoogleCalendarEventController < ApplicationController
    before_action :set_meeting
    before_action :set_meeting_member

    # POST /meetings/:meeting_id/google_calendar_event
    def create
      message = create_event

      redirect_to(group_path(@meeting.group_id), notice: message)
    end

    # DELETE /meetings/:meeting_id/google_calendar_event
    def destroy
      message = destroy_event

      redirect_to(group_path(@meeting.group_id), notice: message)
    end

    private

    def create_event
      uploader = CalendarUploader.new(current_user.google_access_token)
      success, response = rescue_google_calendar_ex do
        uploader.upload_event(@meeting.name, @meeting.date_time)
      end

      event_id = success ? response.try(:id) : response
      generate_message(success, event_id, 'create') do
        @meeting_member.update_column(:google_cal_event_id, event_id)
      end
    end

    def destroy_event
      uploader = CalendarUploader.new(current_user.google_access_token)
      success, response = rescue_google_calendar_ex do
        uploader.delete_event(@meeting_member.google_cal_event_id)
      end

      generate_message(success, response, 'destroy') do
        @meeting_member.update_column(:google_cal_event_id, nil)
      end
    end

    def generate_message(success, response, action)
      if success
        if response
          yield
          t("meetings.google_cal.#{action}.success")
        else
          t("meetings.google_cal.#{action}.error")
        end
      else

        t("meetings.google_cal.#{action}.error") + ' ' + response
      end
    end

    def rescue_google_calendar_ex
      response = yield
      [true, response]
    rescue Google::Apis::ClientError => ex
      [false, ex.message]
    rescue Google::Apis::ServerError => ex
      [false, ex.message]
    end

    def set_meeting
      @meeting = Meeting.friendly.find(params[:meeting_id])
      @meeting_member = @meeting.meeting_member(current_user)
    rescue ActiveRecord::RecordNotFound
      redirect_to_path(groups_path)
    end

    def set_meeting_member
      @meeting_member = @meeting.meeting_member(current_user)
    end
  end
end
