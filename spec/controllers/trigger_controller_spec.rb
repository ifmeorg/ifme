require 'spec_helper'

describe TriggersController do
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
	 		new_category = create(:category, userid: new_user.id)
	  		new_mood = create(:mood, userid: new_user.id)
	  		new_trigger = attributes_for(:trigger).merge(userid: new_user.id, category: Array.new(1, new_category.id), mood: Array.new(1, new_mood.id))
	  		get :new
    		expect(response).to render_template(:new)
	  		expect{post :create,  trigger: new_trigger}.to change(Trigger, :count).by(1)
		end

		it "GET show" do
			new_user = create(:user1)
			sign_in new_user
	 		new_category = create(:category, userid: new_user.id)
	  		new_mood = create(:mood, userid: new_user.id)
	  		new_strategies = create(:strategy, userid: new_user.id)
	  		new_trigger = create(:trigger, userid: new_user.id, category: Array.new(1, new_category.id), mood: Array.new(1, new_mood.id), strategies: Array.new(1, new_strategies.id))
	  		get :show, id: new_trigger
	  		expect(response).to render_template(:show)
		end

=begin
		it "POST comment" do
	  		get :comment
	  		expect(response).to render_template(:show)
		end
=end

		describe "POST support" do
			it "first time support for triggers" do
				new_user = create(:user1)
				sign_in new_user
		 		new_category = create(:category, userid: new_user.id)
		  		new_mood = create(:mood, userid: new_user.id)
		  		new_trigger = create(:trigger, userid: new_user.id, category: Array.new(1, new_category.id), mood: Array.new(1, new_mood.id))
		  		post "support", :userid => new_user.id, :support_type => "trigger", :support_id => new_trigger.id
		  		expect(response).to redirect_to(trigger_path(new_trigger.id))
			end

			it "supports more triggers" do
				new_user = create(:user1)
				sign_in new_user
		 		new_category = create(:category, userid: new_user.id)
		  		new_mood = create(:mood, userid: new_user.id)
		  		new_trigger = create(:trigger, userid: new_user.id, category: Array.new(1, new_category.id), mood: Array.new(1, new_mood.id))
		  		post "support", :userid => new_user.id, :support_type => "trigger", :support_id => new_trigger.id

		  		other_new_trigger = Trigger.create(userid: new_user.id, category: Array.new(1, new_category.id), mood: Array.new(1, new_mood.id), name: "Other Trigger", why: "Cause", comment: true)
		  		post "support", :userid => new_user.id, :support_type => "trigger", :support_id => other_new_trigger.id
		  		expect(response).to redirect_to(trigger_path(other_new_trigger.id))
			end
		end
		
	end
end
