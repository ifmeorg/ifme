class PagesController < ApplicationController
  def home
  	if user_signed_in?
  		@page_title = "Latest"
  		@triggers = Trigger.order("created_at DESC").all
  		#where("created_at >= ?", 4.week.ago.utc)
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
end
