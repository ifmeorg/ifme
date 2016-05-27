# == Schema Information
#
# Table name: groups
#
#  id          :integer          not null, primary key
#  name        :string(255)
#  created_at  :datetime
#  updated_at  :datetime
#  description :text
#

require 'spec_helper'

describe Group do
  it "creates a group" do
    new_group = create(:group, description: 'Test Description')
    expect(Group.count).to eq(1)
  end

  it "does not create a group" do
    new_group = build(:bad_group)
    expect(new_group).to have(1).error_on(:description)
  end

  describe "#led_by?" do
    context "when user is not a leader of the group" do
      it "returns false" do
        user = create :user1
        group = create :group_with_member, userid: user.id, leader: false

        result = group.led_by?(user)

        expect(result).to be false
      end
    end

    context "when user is a leader of the group" do
      it "returns true" do
        user = create :user1
        group = create :group_with_member, userid: user.id, leader: true

        result = group.led_by?(user)

        expect(result).to be true
      end
    end
  end

  describe ".leaders" do
    context "when group has leaders" do
      it "returns the leaders" do
        leader = create :user1
        non_leader = create :user2
        group = create :group_with_member, userid: leader.id, leader: true
        create :group_member, userid: non_leader.id, groupid: group.id,
                              leader: false

        result = group.leaders

        expect(result).to eq [leader]
      end
    end

    context "when group has no leaders" do
      it "returns an empty array" do
        non_leader = create :user1
        group = create :group_with_member, userid: non_leader.id, leader: false

        result = group.leaders

        expect(result).to eq []
      end
    end
  end
end
