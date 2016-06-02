require 'spec_helper'

describe ApplicationController do
	describe "tag_usage" do
		it "is looking for categories tagged nowhere" do
			new_user = create(:user1)
			new_category = create(:category, userid: new_user.id)
			result = controller.tag_usage(new_category.id, 'category', new_user.id)
		  	expect(result[0].length + result[1].length).to eq(0)
		end
		it "is looking for categories tagged in moments and strategies" do
			new_user = create(:user1)
			new_category = create(:category, userid: new_user.id)
		  	new_moment = create(:moment, userid: new_user.id, category: Array.new(1, new_category.id))
		  	new_strategy = create(:strategy, userid: new_user.id, category: Array.new(1, new_category.id))
		  	result = controller.tag_usage(new_category.id, 'category', new_user.id)
		  	expect(result[0].length + result[1].length).to eq(2)
		end
		it "is looking for moods tagged nowhere" do
			new_user = create(:user1)
			new_mood = create(:mood, userid: new_user.id)
			result = controller.tag_usage(new_mood.id, 'mood', new_user.id)
		  	expect(result.length).to eq(0)
		end
		it "is looking for moods tagged in moments" do
			new_user = create(:user1)
			new_mood = create(:mood, userid: new_user.id)
		  	new_moment = create(:moment, userid: new_user.id, mood: Array.new(1, new_mood.id))
		  	result = controller.tag_usage(new_mood.id, 'mood', new_user.id)
		  	expect(result.length).to eq(1)
		end
		it "is looking for strategies tagged nowhere" do
			new_user = create(:user1)
			new_strategy = create(:strategy, userid: new_user.id)
			result = controller.tag_usage(new_strategy.id, 'strategy', new_user.id)
		  	expect(result.length).to eq(0)
		end
		it "is looking for strategies tagged in moments" do
			new_user = create(:user1)
			new_strategy = create(:strategy, userid: new_user.id)
		  	new_moment = create(:moment, userid: new_user.id, strategies: Array.new(1, new_strategy.id))
		  	result = controller.tag_usage(new_strategy.id, 'strategy', new_user.id)
		  	expect(result.length).to eq(1)
		end
	end

	describe "get_stories" do
		it "has no stories and does not include allies" do
			new_user = create(:user1)
			sign_in new_user
	  		expect(controller.get_stories(new_user, false).length).to eq(0)
		end

		it "has only moments and does not include allies" do
			new_user = create(:user1)
			sign_in new_user
			new_moment = create(:moment, userid: new_user.id)
			expect(controller.get_stories(new_user, false).length).to eq(1)
		end

		it "has only strategies and does not include allies" do
			new_user = create(:user1)
			sign_in new_user
			new_strategy = create(:strategy, userid: new_user.id)
			expect(controller.get_stories(new_user, false).length).to eq(1)
		end

		it "has both moments and strategies, and does not include allies" do
			new_user = create(:user1)
			sign_in new_user
			new_moment = create(:moment, userid: new_user.id)
			new_strategy = create(:strategy, userid: new_user.id)
			expect(controller.get_stories(new_user, false).length).to eq(2)

		end

		it "has no stories and does include allies" do
			new_user1 = create(:user1)
			new_user2 = create(:user2)
			new_allies = create(:allyships_accepted, user_id: new_user1.id, ally_id: new_user2.id)
			sign_in new_user1
	  		expect(controller.get_stories(new_user1, true).length).to eq(0)
		end

		it "has only moments and does include allies" do
			new_user1 = create(:user1)
			new_user2 = create(:user2)
			new_allies = create(:allyships_accepted, user_id: new_user1.id, ally_id: new_user2.id)
			sign_in new_user1
			new_moment1 = create(:moment, userid: new_user1.id)
			new_moment2 = create(:moment, userid: new_user2.id, viewers: [new_user1.id])
			expect(controller.get_stories(new_user1, true).length).to eq(2)
		end

		it "has only strategies and does include allies" do
			new_user1 = create(:user1)
			new_user2 = create(:user2)
			new_allies = create(:allyships_accepted, user_id: new_user1.id, ally_id: new_user2.id)
			sign_in new_user1
			new_strategy1 = create(:strategy, userid: new_user1.id)
			new_strategy2 = create(:strategy, userid: new_user2.id, viewers: [new_user1.id])
			expect(controller.get_stories(new_user1, true).length).to eq(2)
		end

		it "has both moments and strategies, and does include allies" do
			new_user1 = create(:user1)
			new_user2 = create(:user2)
			new_allies = create(:allyships_accepted, user_id: new_user1.id, ally_id: new_user2.id)
			sign_in new_user1
			new_moment1 = create(:moment, userid: new_user1.id)
			new_strategy2 = create(:strategy, userid: new_user2.id, viewers: [new_user1.id])
			expect(controller.get_stories(new_user1, true).length).to eq(2)

		end
	end

	describe "moments_stats" do
		it "has no moments" do
			new_user = create(:user1)
			sign_in new_user
	  		expect(controller.moments_stats).to eq('')
		end

		it "has one moment" do
			new_user = create(:user1)
			sign_in new_user
			new_moment = create(:moment, userid: new_user.id)
			expect(controller.moments_stats).to eq('')
		end

		it "has more than one moment created this month" do
			new_user = create(:user1)
			sign_in new_user
			new_moment1 = create(:moment, userid: new_user.id)
			new_moment2 = create(:moment, userid: new_user.id)
			expect(controller.moments_stats).to eq('<div class="center" id="stats">You have written a <strong>total</strong> of <strong>2</strong> moments.</div>')
		end

		it "has more than one moment created on different months" do
			new_user = create(:user1)
			sign_in new_user
			new_moment1 = create(:moment, userid: new_user.id, created_at: '2014-01-01 00:00:00')
			new_moment2 = create(:moment, userid: new_user.id)

			expect(controller.moments_stats).to eq('<div class="center" id="stats">You have written a <strong>total</strong> of <strong>2</strong> moments. This <strong>month</strong> you wrote <strong>1</strong> moment.</div>')

			new_moment3 = create(:moment, userid: new_user.id)

			expect(controller.moments_stats).to eq('<div class="center" id="stats">You have written a <strong>total</strong> of <strong>3</strong> moments. This <strong>month</strong> you wrote <strong>2</strong> moments.</div>')
		end
	end
end
