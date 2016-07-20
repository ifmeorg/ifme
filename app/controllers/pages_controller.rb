class PagesController < ApplicationController
  def home
  	if user_signed_in?
      @stories = Kaminari.paginate_array(get_stories(current_user, true)).page(params[:page]).per($per_page)

      if !@stories.blank? && @stories.count > 0
        @moment = Moment.new
        @categories = Category.where(userid: current_user.id).all.order("created_at DESC")
        @moods = Mood.where(userid: current_user.id).all.order("created_at DESC")
      end
  	end
  end

  def about
  end

  def contributors
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
      ['Elana Hashman', 'https://github.com/ehashman'],
      ['Caleb Thompson', 'https://github.com/calebthompson'],
      ['Stella Cotton', 'https://github.com/stellacotton'],
      ['Karen Kelley', 'https://github.com/kkelleey'],
      ['Gwen Weston', 'https://github.com/gwengrid'],
      ['Mark Freeman', 'http://markfreeman.ca'],
      ['Catherine Vendryes', 'http://catherinevendryes.com'],
      ['Michelle Liauw', 'https://github.com/techiemichelle'],
      ['Kerry Benjamin', 'https://twitter.com/kerry_benjamin1'],
      ['Sylvia Pereira', 'https://github.com/sylviapereira'],
      ['Jonathan Garnaas-Holmes', 'https://github.com/finitem'],
      ['Rashmi Agarwal', 'https://github.com/rashmiagar']
    ]

    @organizations = [
      ['Hacker Hours', 'http://hackerhours.org'],
      ['Open Sourcing Mental Illness', 'https://osmihelp.org'],
      ['Contributor Convenant', 'http://contributor-covenant.org'],
      ['Everybody Has a Brain', 'http://everbodyhasabrain.com']
    ]
  end

  def blog
  end

  def privacy
  end

  def faq
  end
end
