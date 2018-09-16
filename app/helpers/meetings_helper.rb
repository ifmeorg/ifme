# frozen_string_literal: true

module MeetingsHelper
  include FormHelper

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

  def new_meeting_props
    new_form_props(meeting_form_inputs, meetings_path)
  end

  def edit_meeting_props
    edit_form_props(meeting_form_inputs, meeting_path(@meeting))
  end

  private

  def meeting_form_inputs
    [
      {
        id: 'meeting_name',
        type: 'text',
        name: 'meeting[name]',
        label: t('common.name'),
        value: @meeting.name || nil,
        required: true,
        dark: true
      },
      {
        id: 'meeting_location',
        type: 'text',
        name: 'meeting[location]',
        label: t('common.form.location'),
        value: @meeting.location || nil,
        placeholder: t('meetings.form.location_placeholder'),
        required: true,
        dark: true,
      },
      {
        id: 'meeting_time',
        type: 'time',
        name: 'meeting[time]',
        label: t('meetings.info.meeting_time'),
        value: @meeting.time || nil,
        required: true,
        dark: true,
      },
      {
        id: 'meeting_date',
        type: 'date',
        name: 'meeting[date]',
        label: t('common.date'),
        value: @meeting.date || nil,
        required: true,
        dark: true,
      },
      {
        id: 'meeting_maxmembers',
        type: 'number',
        name: 'meeting[maxmembers]',
        label: t('meetings.form.maximum_members'),
        value: @meeting.maxmembers.to_s || nil,
        placeholder: t('meetings.form.maximum_placeholder'),
        min: 0,
        required: true,
        dark: true,
      },
      {
        id: 'meeting_description',
        type: 'textarea',
        name: 'meeting[description]',
        label: t('common.form.description'),
        value: @meeting.description || nil,
        required: true,
        dark: true,
      },
      {
        id: 'meeting_group_id',
        type: 'hidden',
        name: 'meeting[group_id]',
        value:  @group_id || @meeting.group_id
      }
    ]
  end

  def not_attending(id)
    t('shared.meeting_info.not_attending',
      join:
        link_to(
          t('common.actions.join'),
          join_meetings_path(meeting_id: id)
        ))
  end

  def attending(id)
    t('shared.meeting_info.attending') +
    ' ' +
    link_to(
      t('common.actions.leave'),
      leave_meetings_path(meeting_id: id)
    )
  end

  def one_spot(id)
    t('shared.meeting_info.not_attending_one_spot_left',
      join:
        link_to(
          t('common.actions.join'),
          join_meetings_path(meeting_id: id)
        ))
  end

  def many_spots(id, meeting_space)
    t('shared.meeting_info.not_attending_spots_left',
      number: meeting_space,
      join:
        link_to(
          t('common.actions.join'),
          join_meetings_path(meeting_id: id)
        ))
  end

  def in_meeting(meeting)
    if meeting.members.include?(current_user)
      attending(meeting.id)
    elsif meeting.maxmembers.zero?
      not_attending(meeting.id)
    end
  end

  def spots(meeting)
    meeting_space = meeting.maxmembers - meeting.members.count
    if meeting_space == 1
      one_spot(meeting.id)
    elsif meeting_space > 1
      many_spots(meeting.id, meeting_space)
    end
  end
end
