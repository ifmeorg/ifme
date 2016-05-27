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
end
