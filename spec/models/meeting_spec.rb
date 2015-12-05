# == Schema Information
#
# Table name: meetings
#
#  id          :integer          not null, primary key
#  name        :string(255)
#  description :text
#  location    :text
#  time        :string(255)
#  maxmembers  :integer
#  groupid     :integer
#  created_at  :datetime
#  updated_at  :datetime
#  date        :string(255)
#

require 'spec_helper'

describe Meeting do
 	it "creates a meeting" do
 		new_group = create(:group, description: 'Test Description')
 		new_meeting = create(:meeting, groupid: new_group.id, date: 'May 1, 2015')
	  	expect(Meeting.count).to eq(1)
 	end
 	it "does not create a meeting" do
 		new_meeting = build(:meeting)
	  	expect(new_meeting).to have(1).error_on(:groupid)
 	end
end
