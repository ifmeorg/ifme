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
 	it "creates a group member" do
 		new_group = create(:group, description: 'Test Description')
 		new_group_member = create(:group_member, groupid: new_group.id, leader: true)
	  	expect(GroupMember.count).to eq(1)
 	end
 	it "does not create a group member" do
 		new_group_member = build(:group_member, leader: true)
	  	expect(new_group_member).to have(1).error_on(:groupid)
 	end
end
