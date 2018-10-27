# frozen_string_literal: true

describe MeetingsHelper do
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
end
