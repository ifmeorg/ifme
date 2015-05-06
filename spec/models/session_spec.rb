require 'spec_helper'

describe Session do
 	it "creates a session" do
 		new_group = create(:group, description: 'Test Description')
 		new_session = create(:session, groupid: new_group.id)
	  	expect(Session.count).to eq(1)
 	end
 	it "does not create a session" do
 		new_session = build(:session)
	  	expect(new_session).to have(1).error_on(:groupid)
 	end
end