module MeetingsHelper
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
    '\n' +
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
end
