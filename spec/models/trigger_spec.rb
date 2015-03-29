require 'spec_helper'

describe Trigger do 
	describe "POST create" do
		it "create private trigger" do
			new_user = create(:user1)
		 	new_category = create(:category, userid: new_user.id)
		  	new_mood = create(:mood, userid: new_user.id)
		  	new_trigger = create(:trigger, userid: new_user.id, category: Array.new(1, new_category.id), mood: Array.new(1, new_mood.id), post_type: 0)
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
			new_trigger = create(:trigger, userid: new_user.id, category: Array.new(1, new_category.id), mood: Array.new(1, new_mood.id), post_type: 1)
			expect(new_trigger.post_type).to eq(1)
			expect(new_trigger.viewers).to eq(Ally.where(:status => 0).pluck(:id))
		end
	end
end
