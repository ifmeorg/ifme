# frozen_string_literal: true
module MeetingFormHelper
  include FormHelper

  def new_meeting_props(group)
    new_form_props(meeting_form_inputs(nil, group), meetings_path)
  end

  def edit_meeting_props(meeting)
    edit_form_props(meeting_form_inputs(meeting, nil), meeting_path(meeting))
  end

  private

  def meeting_input_props(field, type, label, value)
    {
      id: "meeting_#{field}",
      type: type,
      name: "meeting[#{field}]",
      label: t(label),
      value: value || nil,
      required: true,
      dark: true
    }
  end

  def meeting_group_id(value)
    {
      id: 'meeting_group_id',
      type: 'hidden',
      name: 'meeting[group_id]',
      value: value || nil
    }
  end

  def meeting_maxmembers(meeting)
    meeting_input_props(
      'maxmembers',
      'number',
      'meetings.form.maximum_members',
      meeting&.maxmembers.to_s
    ).merge(
      placeholder: t('meetings.form.maximum_placeholder'), min: 0
    )
  end

  def meeting_location(meeting)
    meeting_input_props(
      'location',
      'text',
      'common.form.location',
      meeting&.location
    ).merge(placeholder: t('meetings.form.location_placeholder'))
  end

  def meeting_time(meeting)
    meeting_input_props(
      'time', 'time', 'meetings.info.meeting_time', meeting&.time
    )
  end

  def meeting_description(meeting)
    meeting_input_props(
      'description', 'textarea', 'common.form.description', meeting&.description
    )
  end

  def meeting_form_inputs(meeting, group)
    [
      meeting_input_props('name', 'text', 'common.name', meeting&.name),
      meeting_location(meeting),
      meeting_time(meeting),
      meeting_input_props('date', 'date', 'common.date', meeting&.date),
      meeting_maxmembers(meeting),
      meeting_description(meeting),
      meeting_group_id(group&.id || meeting&.group_id)
    ]
  end
end
