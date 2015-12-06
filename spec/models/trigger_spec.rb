# == Schema Information
#
# Table name: triggers
#
#  id         :integer          not null, primary key
#  category   :text
#  name       :string(255)
#  mood       :string(255)
#  why        :text
#  fix        :text
#  created_at :datetime
#  updated_at :datetime
#  userid     :integer
#  viewers    :text
#  comment    :boolean
#  strategies :text
#

require 'spec_helper'

describe Trigger do
	describe "POST create" do
		it "create private trigger" do
			new_user = create(:user1)
		 	new_category = create(:category, userid: new_user.id)
		  	new_mood = create(:mood, userid: new_user.id)
		  	new_trigger = create(:trigger, userid: new_user.id, category: Array.new(1, new_category.id), mood: Array.new(1, new_mood.id))
		  	expect(new_trigger.viewers).to be_empty
		  end
	end
	describe "POST create" do
		it "create public trigger" do
		 	new_user = create(:user1)
		 	new_user2 = create(:user2)
		 	new_allies = create(:allies_accepted, userid1: new_user.id, userid2: new_user2.id)
		  	new_category = create(:category, userid: new_user.id)
			new_mood = create(:mood, userid: new_user.id)
			new_trigger = create(:trigger, userid: new_user.id, category: Array.new(1, new_category.id), mood: Array.new(1, new_mood.id), viewers: [new_user2.id])
			expect(new_trigger.viewers.count).to eq(1)
		end
	end
end
