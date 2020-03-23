# frozen_string_literal: true

# Public: Used for sending reminders regarding upcoming meetings
class MeetingReminders
  def send_meeting_reminder_emails
    meetings_tomorrow.each do |meeting|
      meeting.members.each do |member|
        NotificationMailer.meeting_reminder(meeting, member).deliver_now
      end
    end
  end

  private

  def meetings_tomorrow
    tomorrow_as_string = 1.day.from_now.strftime('%m/%d/%Y')
    Meeting.where(date: tomorrow_as_string)
  end
end
