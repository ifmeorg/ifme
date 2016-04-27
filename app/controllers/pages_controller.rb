class PagesController < ApplicationController
  def home
  	if user_signed_in?
  		@page_title = "Latest"

      @triggers = Array.new
      all_triggers = Trigger.order("created_at DESC").all
      all_triggers.each do |trigger|
        if current_user.id == trigger.userid || are_allies(current_user.id, trigger.userid) && is_viewer(trigger.viewers)
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

    @contributors = [
      ['Elizabeth Mitchell', 'https://github.com/emitche'],
      ['William Horton', 'https://github.com/wdhorton'],
      ['Bella Woo', 'https://github.com/bellawoo'],
      ['Julie Pagano', 'https://github.com/juliapagano'],
      ['Fiona Conn', 'https://github.com/fpcyan'],
      ['Iuliia Kotlenko', 'https://github.com/IuliiaKot'],
      ['Daniel Levenson', 'https://github.com/dleve123'],
      ['Dawa Sherpa', 'https://github.com/Dawa12'],
      ['Tien Yuan', 'https://github.com/tienyuan'],
      ['chenghw', 'https://github.com/chenghw'],
      ['Danny Burgoyne', 'https://github.com/dburgoyne'],
      ['Jellene Khoh', 'https://github.com/jellene4eva'],
      ['John Lim', 'https://github.com/jolim24601'],
      ['Danny Glatstein', 'https://github.com/danielglatstein'],
      ['Tess Gadwa', 'http://www.yesexactly.com'],
      ['Mark Farrell', 'https://github.com/markfarrell']
    ]
  end

  def blog
    @page_title = "Blog"
  end

  def privacy
    @page_title = "Privacy Policy"
  end
end
