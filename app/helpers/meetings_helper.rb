# frozen_string_literal: true

module MeetingsHelper
  include CalendarHelper

  def calendar_uploader_params(meeting)
    d = Date.strptime(meeting.date, '%m/%d/%Y')
    t = Time.parse(meeting.time)
    fd = DateTime.new(d.year, d.month, d.day, t.hour, t.min, t.sec)
    fulldate = fd.strftime('%Y/%m/%d %H:%M:%S')
    { summary: meeting.name,
      date: fulldate,
      calendar_id: 'primary',
      access_token: current_user.google_access_token,
      email: current_user.email }
  end

  def empty_calendar_uploader_params(meeting)
    google_event_id = meeting.meeting_members.where(
      userid: current_user
    ).first.google_event_id
    { summary: nil,
      date: nil,
      calendar_id: 'primary',
      access_token: current_user.google_access_token,
      event_id: google_event_id,
      email: current_user.email }
  end

  private def not_attending(id)
    t('shared.meeting_info.not_attending',
      join:
        link_to(
          t('common.actions.join'),
          join_meetings_path(meetingid: id)
        ))
  end

  private def attending(id)
    t('shared.meeting_info.attending') +
    ' ' +
    link_to(
      t('common.actions.leave'),
      leave_meetings_path(meetingid: id)
    )
  end

  private def one_spot(id)
    t('shared.meeting_info.not_attending_one_spot_left',
      join:
        link_to(
          t('common.actions.join'),
          join_meetings_path(meetingid: id)
        ))
  end

  private def many_spots(id, meeting_space)
    t('shared.meeting_info.not_attending_spots_left',
      number: meeting_space,
      join:
        link_to(
          t('common.actions.join'),
          join_meetings_path(meetingid: id)
        ))
  end

  private def in_meeting(meeting)
    if meeting.members.include?(current_user)
      attending(meeting.id)
    elsif meeting.maxmembers.zero?
      not_attending(meeting.id)
    end
  end

  private def spots(meeting)
    meeting_space = meeting.maxmembers - meeting.members.count
    if meeting_space == 1
      one_spot(meeting.id)
    elsif meeting_space > 1
      many_spots(meeting.id, meeting_space)
    end
  end

  def get_meeting_members(meeting)
    meeting_spots = spots(meeting)
    in_meeting = in_meeting(meeting)
    if in_meeting.present?
      raw in_meeting
    elsif meeting_spots.present?
      raw meeting_spots
    else
      t('shared.meeting_info.not_attending_no_spots_left')
    end
  end

  private def gcal_event_exists?(meeting)
    member = meeting.meeting_members.where(userid: current_user).first
    return false unless member.google_event_id
    event = CalendarUploader.new(
      summary: '',
      date: '',
      email: '',
      access_token: current_user.google_access_token,
      calendar_id: 'primary',
      event_id: member.google_event_id
    ).get_event
    true if event && !event.status.eql?('cancelled')
  end

  def add_event_to_gcal(meeting)
    return false unless current_user.google_oauth2_enabled?
    args = calendar_uploader_params(meeting)
    res = CalendarUploader.new(args).upload_event
    meeting_member = meeting.meeting_members.where(userid: current_user).first
    meeting_member.google_event_id = res.id
    meeting_member.save
  end

  def delete_event_from_gcal(meeting)
    return false unless current_user.google_oauth2_enabled?
    args = empty_calendar_uploader_params(meeting)
    CalendarUploader.new(args).delete_event
  end

  def google_calendar(meeting)
    if (meeting.members.include? current_user) &&
       current_user.google_oauth2_enabled? && gcal_event_exists?(meeting)
      link_to(
        t('common.actions.google_cal_delete'),
        delete_gcal_event_meetings_path(meetingid: meeting.id)
      )
    else
      link_to(
        t('common.actions.google_cal_add'),
        add_gcal_event_meetings_path(meetingid: meeting.id)
      )
    end
  end
end
