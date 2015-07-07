require 'rails_helper'

describe MeetingMember do
 	it "creates a meeting member" do
 		new_group = create(:group, description: 'Test Description')
 		new_meeting = create(:meeting, groupid: new_group.id, date: 'May 1, 2015')
 		new_meeting_member = create(:meeting_member, meetingid: new_meeting.id, leader: true)
	  	expect(MeetingMember.count).to eq(1)
 	end
 	it "does not create a meetin member" do
 		new_group = create(:group, description: 'Test Description')
 		new_meeting = create(:meeting, groupid: new_group.id, date: 'May 1, 2015')
 		new_meeting_member = build(:meeting_member, leader: true)
	  	expect(new_meeting_member).to have(1).error_on(:meetingid)
 	end
end