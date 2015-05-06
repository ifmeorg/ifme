require 'spec_helper'

describe Meeting do
 	it "creates a meeting" do
 		new_group = create(:group, description: 'Test Description')
 		new_meeting = create(:meeting, groupid: new_group.id)
	  	expect(Meeting.count).to eq(1)
 	end
 	it "does not create a meeting" do
 		new_meeting = build(:meeting)
	  	expect(new_meeting).to have(1).error_on(:groupid)
 	end
end