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

require 'rails_helper'

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
end
