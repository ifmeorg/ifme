# frozen_string_literal: true

describe MeetingsHelper do
  let(:meeting) { create(:meeting) }
  let(:meeting_member) { create(:meeting_member, meeting: meeting) }
  let(:current_user) { meeting_member.user }

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

  describe '#google_cal_actions' do
    context 'when event is not added to google calendar' do
      it 'returns link for adding the event to google calendar' do
        expect(current_user).to receive(:google_oauth2_enabled?).and_return(true)
        result = google_cal_actions(meeting.reload)
        expect(result).to eq(
          add_to_google_cal: {
            name: t('meetings.google_cal.create.add'),
            link: meeting_google_calendar_event_path(meeting),
            dataMethod: 'post'
          }
        )
      end
    end

    context 'when event is added to google cal' do
      it 'returns link for removing the event from google calendar' do
        meeting_member.update_column(:google_cal_event_id, 'id1')
        expect(current_user).to receive(:google_oauth2_enabled?).and_return(true)
        result = google_cal_actions(meeting.reload)
        expect(result).to eq(
          remove_from_google_cal: {
            name: t('meetings.google_cal.destroy.remove'),
            link: meeting_google_calendar_event_path(meeting),
            dataMethod: 'delete'
          }
        )
      end
    end
  end
end
