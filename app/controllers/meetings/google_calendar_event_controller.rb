# frozen_string_literal: true
module Meetings
  class GoogleCalendarEventController < ApplicationController
    before_action :set_meeting
    before_action :set_meeting_member

    # POST /meetings/:meeting_id/google_calendar_event
    def create
      uploader = CalendarUploader.new(current_user.google_access_token)
      result = uploader.upload_event(@meeting.name, @meeting.date_time)

      if result.try(:id)
        @meeting_member.update_column(:google_cal_event_id, result.id)
        redirect_to(group_path(@meeting.group_id),
                    notice: t('meetings.google_cal.create.success'))
        return
      end
      redirect_to(group_path(@meeting.group_id),
                  notice: t('meetings.google_cal.create.error'))
    end

    # DELETE /meetings/:meeting_id/google_calendar_event
    def destroy
      uploader = CalendarUploader.new(current_user.google_access_token)
      result = uploader.delete_event(@meeting_member.google_cal_event_id)

      if result
        @meeting_member.update_column(:google_cal_event_id, nil)
        redirect_to(group_path(@meeting.group_id),
                    notice: t('meetings.google_cal.destroy.success'))
        return
      end
      redirect_to(group_path(@meeting.group_id),
                  notice: t('meetings.google_cal.destroy.error'))
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
  end
end
