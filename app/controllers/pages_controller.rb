class PagesController < ApplicationController
  def home
  	if user_signed_in?
      @page_title = "Welcome"

      @moments = Array.new
      all_moments = Moment.order("created_at DESC").all
      all_moments.each do |moment|
        if current_user.id == moment.userid || (are_allies(current_user.id, moment.userid) && is_viewer(moment.viewers))
          @moments.push(moment)
        end
      end

      if @moments.count > 0 
        @moment = Moment.new
        @categories = Category.where(userid: current_user.id).all.order("created_at DESC")
        @moods = Mood.where(userid: current_user.id).all.order("created_at DESC")
        @page_title = "Latest Moments"
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
      ['Mark Farrell', 'https://github.com/markfarrell'],
      ['Laura Evans', 'https://github.com/lksevans12'],
      ['Christopher De Borja', 'https://github.com/cdeborja'],
      ['Dominic Prescod', 'https://github.com/dominicprescod'],
      ['Noah Finnerman', 'https://github.com/nonothetoad'],
      ['David Tomberlin', 'https://github.com/siyegen'],
      ['Elana Hashman', 'https://github.com/ehashman']
    ]

    @organizations = [
      ['Hacker Hours', 'http://hackerhours.org'],
      ['Open Sourcing Mental Illness', 'https://osmihelp.org']
    ]
  end

  def blog
    @page_title = "Blog"
  end

  def privacy
    @page_title = "Privacy Policy"
  end
end
