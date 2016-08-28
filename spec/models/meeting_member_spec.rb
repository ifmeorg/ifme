# == Schema Information
#
# Table name: meeting_members
#
#  id         :integer          not null, primary key
#  meetingid  :integer
#  userid     :integer
#  leader     :boolean
#  created_at :datetime
#  updated_at :datetime
#

describe MeetingMember do
  it "has a valid factory" do
    meeting_member = build :meeting_member
    expect(meeting_member).to be_valid
  end

  context "when meetingid is nil" do
    it "is invalid" do
      meeting_member = build :meeting_member, meetingid: nil
      expect(meeting_member).to have(1).error_on(:meetingid)
    end
  end
end
