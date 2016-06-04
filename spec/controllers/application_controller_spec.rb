require 'spec_helper'

describe ApplicationController do
	describe "print_list_links" do
		it "returns empty result for empty array" do
			expect(controller.print_list_links([])).to eq('')
		end
		it "returns empty result for malformed array" do
			expect(controller.print_list_links(['test'])).to eq('')
			expect(controller.print_list_links([['test']])).to eq('')
		end
		it "returns correct result for one link" do
			expect(controller.print_list_links([['test', 'http://if-me.org']])).to eq('<a href="http://if-me.org">test</a>')
		end
		it "returns correct result for two links" do
			expect(controller.print_list_links([['test1', 'http://if-me.org'], ['test2', 'http://if-me.org']])).to eq('<a href="http://if-me.org">test1</a>, <a href="http://if-me.org">test2</a>')
		end
	end
	describe "most_focus" do
		describe "categories" do
			it "returns an empty hash because no categories exist" do
				new_user = create(:user1)
				sign_in new_user
				new_moment = create(:moment, userid: new_user.id)
				new_strategy = create(:strategy, userid: new_user.id)
				expect(controller.most_focus('category', nil).length).to eq(0)
			end
			describe "returns a hash because categories exist" do
				it "returns a hash of size 1 when the same category is used twice" do
					new_user = create(:user1)
					sign_in new_user
					new_category = create(:category, userid: new_user.id)
					new_moment = create(:moment, userid: new_user.id, category: Array.new(1, new_category.id))
					new_strategy = create(:strategy, userid: new_user.id, category: Array.new(1, new_category.id))
					result = controller.most_focus('category', nil)
					expect(result.length).to eq(1)
					expect(result[new_category.id]).to eq(2)
				end
				it "returns a hash of size 2" do
					new_user = create(:user1)
					sign_in new_user
					new_category1 = create(:category, userid: new_user.id)
					new_category2 = create(:category, userid: new_user.id)
					new_moment = create(:moment, userid: new_user.id, category: Array.new(1, new_category1.id))
					new_strategy = create(:strategy, userid: new_user.id, category: Array.new(1, new_category2.id))
					result = controller.most_focus('category', nil)
					expect(result.length).to eq(2)
					expect(result[new_category1.id]).to eq(1)
					expect(result[new_category2.id]).to eq(1)
				end
				it "returns a correct hash of size 3" do
					new_user = create(:user1)
					sign_in new_user
					new_category1 = create(:category, userid: new_user.id)
					new_category2 = create(:category, userid: new_user.id)
					new_category3 = create(:category, userid: new_user.id)
					new_category4 = create(:category, userid: new_user.id)
					new_moment = create(:moment, userid: new_user.id, category: Array.new(1, new_category2.id))
					new_strategy = create(:strategy, userid: new_user.id, category: [new_category1.id, new_category2.id, new_category3.id, new_category4.id])
					result = controller.most_focus('category', nil)
					expect(result.length).to eq(3)
					expect(result[new_category1.id]).to eq(1)
					expect(result[new_category2.id]).to eq(2)
					expect(result[new_category3.id]).to eq(1)
					expect(result[new_category4.id]).to eq(nil)
				end
				it "returns a correct hash of size 1 belonging to another user" do
					new_user1 = create(:user1)
					new_user2 = create(:user2)
					sign_in new_user1
					new_category1 = create(:category, userid: new_user2.id)
					new_category2 = create(:category, userid: new_user2.id)
					new_category3 = create(:category, userid: new_user2.id)
					new_category4 = create(:category, userid: new_user2.id)
					new_moment = create(:moment, userid: new_user2.id, category: Array.new(1, new_category2.id), viewers: Array.new(1, new_user1.id))
					new_strategy = create(:strategy, userid: new_user2.id, category: [new_category1.id, new_category2.id, new_category3.id, new_category4.id])
					result = controller.most_focus('category', new_user2.id)
					expect(result.length).to eq(1)
					expect(result[new_category1.id]).to eq(nil)
					expect(result[new_category2.id]).to eq(1)
					expect(result[new_category3.id]).to eq(nil)
					expect(result[new_category4.id]).to eq(nil)
				end
			end
		end
		describe "moods" do
			it "returns an empty hash because no moods exist" do
				new_user = create(:user1)
				sign_in new_user
				new_moment = create(:moment, userid: new_user.id)
				expect(controller.most_focus('mood', nil).length).to eq(0)
			end
			describe "returns a hash because moods exist" do
				it "returns a hash of size 1 when the same mood is used twice" do
					new_user = create(:user1)
					sign_in new_user
					new_mood = create(:mood, userid: new_user.id)
					new_moment = create(:moment, userid: new_user.id, mood: Array.new(1, new_mood.id))
					result = controller.most_focus('mood', nil)
					expect(result.length).to eq(1)
					expect(result[new_mood.id]).to eq(1)
				end
				it "returns a hash of size 2" do
					new_user = create(:user1)
					sign_in new_user
					new_mood1 = create(:mood, userid: new_user.id)
					new_mood2 = create(:mood, userid: new_user.id)
					new_moment = create(:moment, userid: new_user.id, mood: [new_mood1.id, new_mood2.id])
					result = controller.most_focus('mood', nil)
					expect(result.length).to eq(2)
					expect(result[new_mood1.id]).to eq(1)
					expect(result[new_mood2.id]).to eq(1)
				end
				it "returns a correct hash of size 3" do
					new_user = create(:user1)
					sign_in new_user
					new_mood1 = create(:mood, userid: new_user.id)
					new_mood2 = create(:mood, userid: new_user.id)
					new_mood3 = create(:mood, userid: new_user.id)
					new_mood4 = create(:mood, userid: new_user.id)
					new_moment1 = create(:moment, userid: new_user.id, mood: Array.new(1, new_mood2.id))
					new_moment2 = create(:moment, userid: new_user.id, mood: [new_mood1.id, new_mood2.id, new_mood3.id, new_mood4.id])
					result = controller.most_focus('mood', nil)
					expect(result.length).to eq(3)
					expect(result[new_mood1.id]).to eq(1)
					expect(result[new_mood2.id]).to eq(2)
					expect(result[new_mood3.id]).to eq(1)
					expect(result[new_mood4.id]).to eq(nil)
				end
				it "returns a correct hash of size 1 belonging to another user" do
					new_user1 = create(:user1)
					new_user2 = create(:user2)
					sign_in new_user1
					new_mood1 = create(:mood, userid: new_user2.id)
					new_mood2 = create(:mood, userid: new_user2.id)
					new_mood3 = create(:mood, userid: new_user2.id)
					new_mood4 = create(:mood, userid: new_user2.id)
					new_moment1 = create(:moment, userid: new_user2.id, mood: Array.new(1, new_mood2.id), viewers: Array.new(1, new_user1.id))
					new_moment2 = create(:moment, userid: new_user2.id, mood: [new_mood1.id, new_mood2.id, new_mood3.id, new_mood4.id])
					result = controller.most_focus('mood', new_user2.id)
					expect(result.length).to eq(1)
					expect(result[new_mood1.id]).to eq(nil)
					expect(result[new_mood2.id]).to eq(1)
					expect(result[new_mood3.id]).to eq(nil)
					expect(result[new_mood4.id]).to eq(nil)
				end
			end
		end
		describe "strategy" do
			it "returns an empty hash because no strategies exist" do
				new_user = create(:user1)
				sign_in new_user
				new_moment = create(:moment, userid: new_user.id)
				expect(controller.most_focus('strategy', nil).length).to eq(0)
			end
			describe "returns a hash because strategies exist" do
				it "returns a hash of size 1 when the same strategy is used twice" do
					new_user = create(:user1)
					sign_in new_user
					new_strategy = create(:strategy, userid: new_user.id)
					new_moment = create(:moment, userid: new_user.id, strategies: Array.new(1, new_strategy.id))
					result = controller.most_focus('strategy', nil)
					expect(result.length).to eq(1)
					expect(result[new_strategy.id]).to eq(1)
				end
				it "returns a hash of size 2" do
					new_user = create(:user1)
					sign_in new_user
					new_strategy1 = create(:strategy, userid: new_user.id)
					new_strategy2 = create(:strategy, userid: new_user.id)
					new_moment = create(:moment, userid: new_user.id, strategies: [new_strategy1.id, new_strategy2.id])
					result = controller.most_focus('strategy', nil)
					expect(result.length).to eq(2)
					expect(result[new_strategy1.id]).to eq(1)
					expect(result[new_strategy2.id]).to eq(1)
				end
				it "returns a correct hash of size 3" do
					new_user = create(:user1)
					sign_in new_user
					new_strategy1 = create(:strategy, userid: new_user.id)
					new_strategy2 = create(:strategy, userid: new_user.id)
					new_strategy3 = create(:strategy, userid: new_user.id)
					new_strategy4 = create(:strategy, userid: new_user.id)
					new_moment1 = create(:moment, userid: new_user.id, strategies: Array.new(1, new_strategy2.id))
					new_moment2 = create(:moment, userid: new_user.id, strategies: [new_strategy1.id, new_strategy2.id, new_strategy3.id, new_strategy4.id])
					result = controller.most_focus('strategy', nil)
					expect(result.length).to eq(3)
					expect(result[new_strategy1.id]).to eq(1)
					expect(result[new_strategy2.id]).to eq(2)
					expect(result[new_strategy3.id]).to eq(1)
					expect(result[new_strategy4.id]).to eq(nil)
				end
				it "returns a correct hash of size 1 belonging to another user" do
					new_user1 = create(:user1)
					new_user2 = create(:user2)
					sign_in new_user1
					new_strategy1 = create(:strategy, userid: new_user2.id)
					new_strategy2 = create(:strategy, userid: new_user2.id)
					new_strategy3 = create(:strategy, userid: new_user2.id)
					new_strategy4 = create(:strategy, userid: new_user2.id)
					new_moment1 = create(:moment, userid: new_user2.id, strategies: Array.new(1, new_strategy2.id), viewers: Array.new(1, new_user1.id))
					new_moment2 = create(:moment, userid: new_user2.id, strategies: [new_strategy1.id, new_strategy2.id, new_strategy3.id, new_strategy4.id])
					result = controller.most_focus('strategy', new_user2.id)
					expect(result.length).to eq(1)
					expect(result[new_strategy1.id]).to eq(nil)
					expect(result[new_strategy2.id]).to eq(1)
					expect(result[new_strategy3.id]).to eq(nil)
					expect(result[new_strategy4.id]).to eq(nil)
				end
			end
		end
	end
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

		it "has no moments and strategies despite being allies with user" do
			new_user1 = create(:user1)
			new_user2 = create(:user2)
			new_allies = create(:allyships_accepted, user_id: new_user1.id, ally_id: new_user2.id)
			sign_in new_user1
			new_moment1 = create(:moment, userid: new_user2.id)
			new_strategy2 = create(:strategy, userid: new_user2.id)
			expect(controller.get_stories(new_user2, false).length).to eq(0)
		end

		it "has both moments and strategies and is allies with user" do
			new_user1 = create(:user1)
			new_user2 = create(:user2)
			new_allies = create(:allyships_accepted, user_id: new_user1.id, ally_id: new_user2.id)
			sign_in new_user1
			new_moment1 = create(:moment, userid: new_user2.id, viewers: [new_user1.id])
			new_strategy2 = create(:strategy, userid: new_user2.id, viewers: [new_user1.id])
			expect(controller.get_stories(new_user2, false).length).to eq(2)
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

	describe "get_viewers_for" do
		it "returns empty array for invalid input" do
			result = controller.get_viewers_for(nil, nil)
			expect(result.length).to eq(0)
		end

		it "returns array of size 1 for valid input of data type category" do
			new_user1 = create(:user1)
			new_user2 = create(:user2)
			new_category = create(:category, userid: new_user1.id)
			new_moment = create(:moment, userid: new_user1.id, category: Array.new(1, new_category.id), viewers: Array.new(1, new_user2.id))
			new_strategy = create(:strategy, userid: new_user1.id, category: Array.new(1, new_category.id), viewers: Array.new(1, new_user2.id))
			result = controller.get_viewers_for(new_category, 'category')
			expect(result.length).to eq(1)
			expect(result[0]).to eq(new_user2.id)
		end

		it "returns array of size 2 for valid input of data type category" do
			new_user1 = create(:user1)
			new_user2 = create(:user2)
			new_user3 = create(:user3)
			new_category = create(:category, userid: new_user1.id)
			new_moment = create(:moment, userid: new_user1.id, category: Array.new(1, new_category.id), viewers: [new_user2.id, new_user3.id])
			new_strategy = create(:strategy, userid: new_user1.id, category: Array.new(1, new_category.id), viewers: Array.new(1, new_user2.id))
			result = controller.get_viewers_for(new_category, 'category')
			expect(result.length).to eq(2)
			expect(result[0]).to eq(new_user2.id)
			expect(result[1]).to eq(new_user3.id)
		end

		it "returns array of size 1 for valid input of data type mood" do
			new_user1 = create(:user1)
			new_user2 = create(:user2)
			new_mood = create(:mood, userid: new_user1.id)
			new_moment = create(:moment, userid: new_user1.id, mood: Array.new(1, new_mood.id), viewers: Array.new(1, new_user2.id))
			result = controller.get_viewers_for(new_mood, 'mood')
			expect(result.length).to eq(1)
			expect(result[0]).to eq(new_user2.id)
		end

		it "returns array of size 2 for valid input of data type mood" do
			new_user1 = create(:user1)
			new_user2 = create(:user2)
			new_user3 = create(:user3)
			new_mood = create(:mood, userid: new_user1.id)
			new_moment = create(:moment, userid: new_user1.id, mood: Array.new(1, new_mood.id), viewers: [new_user2.id, new_user3.id])
			result = controller.get_viewers_for(new_mood, 'mood')
			expect(result.length).to eq(2)
			expect(result[0]).to eq(new_user2.id)
			expect(result[1]).to eq(new_user3.id)
		end

		it "returns array of size 1 for valid input of data type strategy" do
			new_user1 = create(:user1)
			new_user2 = create(:user2)
			new_strategy = create(:strategy, userid: new_user1.id)
			new_moment = create(:moment, userid: new_user1.id, strategies: Array.new(1, new_strategy.id), viewers: Array.new(1, new_user2.id))
			result = controller.get_viewers_for(new_strategy, 'strategy')
			expect(result.length).to eq(1)
			expect(result[0]).to eq(new_user2.id)
		end

		it "returns array of size 2 for valid input of data type strategy" do
			new_user1 = create(:user1)
			new_user2 = create(:user2)
			new_user3 = create(:user3)
			new_strategy = create(:strategy, userid: new_user1.id)
			new_moment = create(:moment, userid: new_user1.id, strategies: Array.new(1, new_strategy.id), viewers: [new_user2.id, new_user3.id])
			result = controller.get_viewers_for(new_strategy, 'strategy')
			expect(result.length).to eq(2)
			expect(result[0]).to eq(new_user2.id)
			expect(result[1]).to eq(new_user3.id)
		end
	end

	describe "viewers_hover" do
		it "displays only you when there are no viewers without link" do
			result = controller.viewers_hover(nil, nil)
			expect(result).to eq('<span class="yes_title small_margin_right" title="Only you"><i class="fa fa-lock"></i></span>')
		end

		it "displays only you when there are no viewers with link" do
			new_user1 = create(:user1)
			new_category = create(:category, userid: new_user1.id)
			new_moment = create(:moment, userid: new_user1.id, category: Array.new(1, new_category.id))
			result = controller.viewers_hover(nil, new_category)
			expect(result).to eq('<span class="yes_title" title="Visible to only you"><a href="/categories/' + new_category.id.to_s + '">Test Category</a></span>')
		end

		it "displays list of viewers without link" do
			new_user1 = create(:user1)
			new_user2 = create(:user2)
			new_user3 = create(:user3)
			result = controller.viewers_hover([new_user1.id, new_user2.id, new_user3.id], nil)
			expect(result).to eq('<span class="yes_title small_margin_right" title="Oprah Chang, Plum Blossom, and Gentle Breezy"><i class="fa fa-lock"></i></span>')
		end

		it "displays list of viewers with link" do
			new_user1 = create(:user1)
			new_user2 = create(:user2)
			new_user3 = create(:user3)
			viewers = [new_user1.id, new_user2.id, new_user3.id]
			new_category = create(:category, userid: new_user1.id)
			new_moment = create(:moment, userid: new_user1.id, category: Array.new(1, new_category.id), viewers: viewers)
			result = controller.viewers_hover(viewers, new_category)
			expect(result).to eq('<span class="yes_title" title="Visible to Oprah Chang, Plum Blossom, and Gentle Breezy"><a href="/categories/' + new_category.id.to_s + '">Test Category</a></span>')
		end
	end
end
