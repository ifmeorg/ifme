# frozen_string_literal: true

describe MeetingsHelper do
  let(:group) { create(:group) }
  let(:meeting) { create(:meeting) }
  let(:current_user) { create(:meeting_member, meeting: meeting).user }

  describe '#get_meeting_members' do
    it 'displays not attending with a link to join' do
      meeting = create(:meeting, members: [], maxmembers: 0)
      result = get_meeting_members(meeting)
      expect(result).to eq("You are not attending. <a href=\"/meetings/join?meeting_id=#{meeting.id}\">Join</a>")
    end

    it 'displays attending with a link to leave' do
      result = get_meeting_members(meeting)
      expect(result).to eq("You are attending. Change your mind? <a href=\"/meetings/leave?meeting_id=#{meeting.id}\">Leave</a>")
    end

    it 'displays there is one spot to join with a link' do
      meeting = create(:meeting)
      result = get_meeting_members(meeting)
      expect(result).to eq("You are not attending. There is one spot left to fill! <a href=\"/meetings/join?meeting_id=#{meeting.id}\">Join</a>")
    end

    it 'displays there are spots to join with a link' do
      meeting = create(:meeting, maxmembers: 2)
      result = get_meeting_members(meeting)
      expect(result).to eq("You are not attending. There are 2 spots left to fill! <a href=\"/meetings/join?meeting_id=#{meeting.id}\">Join</a>")
    end

    it 'displays there is no room to join ' do
      meeting = create(:meeting)
      member = create(:meeting_member, meeting: meeting)
      result = get_meeting_members(meeting)
      expect(result).to eq('You are not attending. There is no room to join.')
    end
  end

  describe '#new_meeting_props' do
    it 'returns correct props' do
      expect(new_meeting_props(group.id)).to eq(
        inputs: [
          {
            id: 'meeting_name',
            type: 'text',
            name: 'meeting[name]',
            label: 'Name',
            value: nil,
            required: true,
            dark: true
          },
          {
            id: 'meeting_location',
            type: 'text',
            name: 'meeting[location]',
            label: 'Location',
            value: nil,
            placeholder: 'URL or street address',
            required: true,
            dark: true
          },
          {
            id: 'meeting_time',
            type: 'time',
            name: 'meeting[time]',
            label: 'Time',
            value: nil,
            required: true,
            dark: true
          },
          {
            id: 'meeting_date',
            type: 'date',
            name: 'meeting[date]',
            label: 'Date',
            value: nil,
            required: true,
            dark: true
          },
          {
            id: 'meeting_maxmembers',
            type: 'number',
            name: 'meeting[maxmembers]',
            label: 'Maximum Members',
            value: '',
            placeholder: '0 if no maximum',
            min: 0,
            required: true,
            dark: true
          },
          {
            id: 'meeting_description',
            type: 'textarea',
            name: 'meeting[description]',
            label: 'Description',
            value: nil,
            required: true,
            dark: true
          },
          {
            id: 'meeting_group_id',
            type: 'hidden',
            name: 'meeting[group_id]',
            value: group.id
          },
          {
            id: 'submit',
            type: 'submit',
            value: 'Submit',
            dark: true
          }
        ],
        action: '/meetings'
      )
    end
  end

  describe '#edit_meeting_props' do
    it 'returns correct props' do
      expect(edit_meeting_props(meeting)).to eq(
        inputs: [
          {
            id: 'meeting_name',
            type: 'text',
            name: 'meeting[name]',
            label: 'Name',
            value: meeting.name,
            required: true,
            dark: true
          },
          {
            id: 'meeting_location',
            type: 'text',
            name: 'meeting[location]',
            label: 'Location',
            value: meeting.location,
            placeholder: 'URL or street address',
            required: true,
            dark: true
          },
          {
            id: 'meeting_time',
            type: 'time',
            name: 'meeting[time]',
            label: 'Time',
            value: meeting.time,
            required: true,
            dark: true
          },
          {
            id: 'meeting_date',
            type: 'date',
            name: 'meeting[date]',
            label: 'Date',
            value: meeting.date,
            required: true,
            dark: true
          },
          {
            id: 'meeting_maxmembers',
            type: 'number',
            name: 'meeting[maxmembers]',
            label: 'Maximum Members',
            value: meeting.maxmembers.to_s,
            placeholder: '0 if no maximum',
            min: 0,
            required: true,
            dark: true
          },
          {
            id: 'meeting_description',
            type: 'textarea',
            name: 'meeting[description]',
            label: 'Description',
            value: meeting.description,
            required: true,
            dark: true
          },
          {
            id: 'meeting_group_id',
            type: 'hidden',
            name: 'meeting[group_id]',
            value: meeting.group_id
          },
          {
            id: '_method',
            name: '_method',
            type: 'hidden',
            value: 'patch'
          },
          {
            id: 'submit',
            type: 'submit',
            value: 'Submit',
            dark: true
          }
        ],
        action: "/meetings/#{meeting.slug}"
      )
    end
  end
end
