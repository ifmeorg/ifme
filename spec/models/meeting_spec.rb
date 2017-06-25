# == Schema Information
#
# Table name: meetings
#
#  id          :integer          not null, primary key
#  name        :string
#  description :text
#  location    :text
#  time        :string
#  maxmembers  :integer
#  groupid     :integer
#  created_at  :datetime
#  updated_at  :datetime
#  date        :string
#  slug        :string
#

describe Meeting do
  it "has a valid factory" do
    result = build :meeting

    expect(result).to be_valid
  end
  context "when meeting does not have a group id" do
    it "is not valid" do
      new_meeting = build(:meeting, groupid: nil)
      expect(new_meeting).to have(1).error_on(:groupid)
    end
  end

  describe ".leaders" do
    context "when group has leaders" do
      it "returns the leaders" do
        leader = create :user1
        non_leader = create :user2
        meeting = create :meeting
        create :meeting_member, userid: leader.id, leader: true,
                                meetingid: meeting.id
        create :meeting_member, userid: non_leader.id, leader: false,
                                meetingid: meeting.id

        result = meeting.leaders

        expect(result).to eq [leader]
      end
    end

    context "when group has no leaders" do
      it "returns an empty array" do
        non_leader = create :user1
        meeting = create :meeting
        create :meeting_member, userid: non_leader.id, leader: false,
                                meetingid: meeting.id

        result = meeting.leaders

        expect(result).to eq []
      end
    end
  end
end
