# == Schema Information
#
# Table name: meeting_members
#
#  id         :integer          not null, primary key
#  meetingid  :integer
#  user_id     :integer
#  leader     :boolean
#  created_at :datetime
#  updated_at :datetime
#

require 'rails_helper'

describe MeetingMember do
  it "has a valid factory" do
    meeting_member = build :meeting_member
    expect(meeting_member).to be_valid
  end

  context "when meetingid is nil" do
    it "is invalid" do
      meeting_member = build :meeting_member, meeting_id: nil
      expect(meeting_member).to have(1).error_on(:meeting_id)
    end
  end
end
