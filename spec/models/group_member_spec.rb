# == Schema Information
#
# Table name: group_members
#
#  id         :integer          not null, primary key
#  groupid    :integer
#  userid     :integer
#  leader     :boolean
#  created_at :datetime
#  updated_at :datetime
#

describe GroupMember do
  it "has a valid factory" do
    group_member = build :group_member
    expect(group_member).to be_valid
  end
  context "when groupid is nil" do
    it "is not valid" do
      group_member = build :group_member, groupid: nil
      expect(group_member).to have(1).error_on(:groupid)
    end
  end

  describe "#meeting_members" do
    context "when it has associated meeting_memberships" do
      it "returns the meeting_memberships" do
        group_member = create :group_member
        meeting = create :meeting, groupid: group_member.groupid
        meeting_member = create :meeting_member, meetingid: meeting.id,
          userid: group_member.userid

        expect(group_member.meeting_memberships).to eq [meeting_member]
      end
    end
  end

  describe "#destroy" do
    context "when it has associated meeting_members" do
      it "destroys the meeting_memberships" do
        group_member = create :group_member
        meeting = create :meeting, groupid: group_member.groupid
        meeting_member = create :meeting_member, meetingid: meeting.id,
          userid: group_member.userid

        expect { group_member.destroy }.to change(MeetingMember, :count).by(-1)
      end
    end
  end
end
