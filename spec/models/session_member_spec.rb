require 'rails_helper'

describe SessionMember do
 	it "creates a session member" do
 		new_group = create(:group, description: 'Test Description')
 		new_session = create(:session, groupid: new_group.id)
 		new_session_member = create(:session_member, sessionid: new_session.id, leader: true)
	  	expect(SessionMember.count).to eq(1)
 	end
 	it "does not create a session member" do
 		new_group = create(:group, description: 'Test Description')
 		new_session = create(:session, groupid: new_group.id)
 		new_session_member = build(:session_member, leader: true)
	  	expect(new_session_member).to have(1).error_on(:sessionid)
 	end
end