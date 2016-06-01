require 'spec_helper'

describe ApplicationController do
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
