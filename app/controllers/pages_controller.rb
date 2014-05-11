class PagesController < ApplicationController
  def home
  	if user_signed_in?
  		@page_title = "Latest"
  		@triggers = Trigger.where("created_at >= ?", 4.week.ago.utc).order("created_at DESC").all
  		@allies = Ally.where(:userid => current_user.id).all
  	else
  		@page_title = "Welcome"
  	end
  end
end
