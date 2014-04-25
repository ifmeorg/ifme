require 'spec_helper'

describe TriggersController do
	describe "signed in" do
		it "GET index" do
			new_user = create(:user)
			sign_in new_user
	  		get :index
	  		response.should render_template("index")
		end

		it "POST new" do
=begin
			new_user = create(:user)
			sign_in new_user
	 		new_category = create(:category, userid: new_user.id)
	  		new_mood = create(:mood, userid: new_user.id)
	  		new_trigger = attributes_for(:trigger).merge(userid: new_user.id, category: Array.new(new_category.id), mood: Array.new(new_mood.id))
	  		puts new_trigger
	  		expect{post :create,  trigger: new_trigger}.to change(Trigger, :count).by(1)
=end
		end

		it "GET show" do
			new_user = create(:user)
			sign_in new_user
	 		new_category = create(:category, userid: new_user.id)
	  		new_mood = create(:mood, userid: new_user.id)
	  		new_trigger = create(:trigger, userid: new_user.id, category: Array.new(new_category.id), mood: Array.new(new_mood.id))
	  		get :show, id: new_trigger
	  		response.should render_template("show")
		end
=begin
		it "POST comment" do
			new_user = create(:user)
			sign_in new_user
			new_category = create(:category, userid: new_user.id)
	  		new_mood = create(:mood, userid: new_user.id)
	  		new_trigger = create(:trigger, userid: new_user.id, category: Array.new(new_category.id), mood: Array.new(new_mood.id))
		end
=end

		describe "POST support" do 
			it "first time support for triggers" do
				new_user = create(:user)
				sign_in new_user
		 		new_category = create(:category, userid: new_user.id)
		  		new_mood = create(:mood, userid: new_user.id)
		  		new_trigger = create(:trigger, userid: new_user.id, category: Array.new(new_category.id), mood: Array.new(new_mood.id))
		  		post "support", :userid => new_user.id, :support_type => "trigger", :support_id => new_trigger.id
		  		response.should redirect_to(trigger_path(new_trigger.id))
			end

			it "supports more triggers" do
				new_user = create(:user)
				sign_in new_user
		 		new_category = create(:category, userid: new_user.id)
		  		new_mood = create(:mood, userid: new_user.id)
		  		new_trigger = create(:trigger, userid: new_user.id, category: Array.new(new_category.id), mood: Array.new(new_mood.id))
		  		post "support", :userid => new_user.id, :support_type => "trigger", :support_id => new_trigger.id
		  		puts "Size (before) >>>"
		  		puts Support.count

		  		other_new_trigger = Trigger.create(userid: new_user.id, category: Array.new(new_category.id), mood: Array.new(new_mood.id), name: "Other Trigger", why: "Cause")
		  		post "support", :userid => new_user.id, :support_type => "trigger", :support_id => other_new_trigger.id
		  		puts "Size (after) >>>"
		  		puts Support.count
		  		response.should redirect_to(trigger_path(other_new_trigger.id))
			end
		end 
	end
end
