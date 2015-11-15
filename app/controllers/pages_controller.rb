class PagesController < ApplicationController
  def home
  	if user_signed_in?
  		@page_title = "Latest"

      @triggers = Array.new
      all_triggers = Trigger.order("created_at DESC").all
      all_triggers.each do |trigger|
        if current_user.id == trigger.userid || are_allies(current_user.id, trigger.userid) && trigger.post_type == 1
          @triggers.push(trigger)
        end
      end
  	else
      @page_title = 'Welcome'
  	end
  end

  def about
    @page_title = "About"
  end

  def contributors
    @page_title = "Contributors"
  end

  def blog
    @page_title = "Blog"
  end

  def privacy
    @page_title = "Privacy Policy"
  end
end
