describe MeetingsHelper do

  describe "get_meeting_members" do
    let(:meeting){FactoryBot.create(:meeting, id:1)}
    let(:current_user) { FactoryBot.create(:meeting_member, meeting: meeting).user }

    it "displays not attending with a link to join" do
      meeting = create(:meeting,  members: [], maxmembers: 0, id: 2)
      result = get_meeting_members(meeting)
      expect(result).to eq("You are not attending. <a href=\"/meetings/join?meetingid=2\">Join</a>")
    end

    it "displays attending with a link to leave" do
      result = get_meeting_members(meeting)
      expect(result).to eq("You are attending. Change your mind? <a href=\"/meetings/leave?meetingid=1\">Leave</a>")
    end

    it "displays there is one spot to join with a link" do
      meeting = create(:meeting, id: 3)
      result = get_meeting_members(meeting)
      expect(result).to eq("You are not attending. There is one spot left to fill! <a href=\"/meetings/join?meetingid=3\">Join</a>")
    end

    it "displays there are spots to join with a link" do
      meeting = create(:meeting, maxmembers: 2, id: 4)
      result = get_meeting_members(meeting)
      expect(result).to eq("You are not attending. There are 2 spots left to fill! <a href=\"/meetings/join?meetingid=4\">Join</a>")
    end

    it "displays there is no room to join " do
      meeting = create(:meeting, id: 5)
      member = create(:meeting_member, meeting: meeting)
      result = get_meeting_members(meeting)
      expect(result).to eq("You are not attending. There is no room to join.")
    end
  end
end
