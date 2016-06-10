require 'spec_helper'

describe MomentsController do
	describe "signed in" do
		it "GET index" do
			new_user = create(:user1)
			sign_in new_user
	  		get :index
	  		expect(response).to render_template(:index)
		end

		it "POST new" do
			new_user = create(:user1)
			sign_in new_user
	 		new_category = create(:category, user_id: new_user.id)
	  		new_mood = create(:mood, user_id: new_user.id)
	  		new_moment = attributes_for(:moment).merge(user_id: new_user.id, category: Array.new(1, new_category.id), mood: Array.new(1, new_mood.id))
	  		get :new
    		expect(response).to render_template(:new)
	  		expect{post :create,  moment: new_moment}.to change(Moment, :count).by(1)
		end

		it "GET show" do
			new_user = create(:user1)
			sign_in new_user
	 		new_category = create(:category, user_id: new_user.id)
	  		new_mood = create(:mood, user_id: new_user.id)
	  		new_strategies = create(:strategy, user_id: new_user.id)
	  		new_moment = create(:moment, user_id: new_user.id, category: Array.new(1, new_category.id), mood: Array.new(1, new_mood.id), strategies: Array.new(1, new_strategies.id))
	  		get :show, id: new_moment
	  		expect(response).to render_template(:show)
		end

=begin
		it "POST comment" do
	  		get :comment
	  		expect(response).to render_template(:show)
		end

		describe "POST support" do
			it "first time support for moments" do
				new_user = create(:user1)
				sign_in new_user
		 		new_category = create(:category, user_id: new_user.id)
		  		new_mood = create(:mood, user_id: new_user.id)
		  		new_moment = create(:moment, user_id: new_user.id, category: Array.new(1, new_category.id), mood: Array.new(1, new_mood.id))
		  		post "support", :user_id => new_user.id, :support_type => "moment", :support_id => new_moment.id
		  		expect(response).to redirect_to(moment_path(new_moment.id))
			end

			it "supports more moments" do
				new_user = create(:user1)
				sign_in new_user
		 		new_category = create(:category, user_id: new_user.id)
		  		new_mood = create(:mood, user_id: new_user.id)
		  		new_moment = create(:moment, user_id: new_user.id, category: Array.new(1, new_category.id), mood: Array.new(1, new_mood.id))
		  		post "support", :user_id => new_user.id, :support_type => "moment", :support_id => new_moment.id

		  		other_new_moment = Moment.create(user_id: new_user.id, category: Array.new(1, new_category.id), mood: Array.new(1, new_mood.id), name: "Other Moment", why: "Cause", comment: true)
		  		post "support", :user_id => new_user.id, :support_type => "moment", :support_id => other_new_moment.id
		  		expect(response).to redirect_to(moment_path(other_new_moment.id))
			end
		end
=end
	end
end
