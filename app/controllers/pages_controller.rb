class PagesController < ApplicationController
  include ActionView::Helpers::AssetTagHelper
  helper_method :print_contributors, :print_partners

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
      ['Jonathan Garnaas-Holmes', 'https://github.com/finitem']
    ]

    @organizations = [
      ['Hacker Hours', 'http://hackerhours.org', '/assets/partners/hacker_hours.png'],
      ['Open Sourcing Mental Illness', 'https://osmihelp.org', '/assets/partners/osmi.png'],
      ['Contributor Convenant', 'http://contributor-covenant.org', '/assets/partners/contributor_convenant.png'],
      ['Everybody Has a Brain', 'http://everybodyhasabrain.com', '/assets/partners/everybody_has_a_brain.png'],
    ]
  end

  def blog
  end

  def privacy
  end

  def faq
  end

  def print_contributors(data)
    first_element = 0
    return_this = ''
    data.each do |d|
      name = d[0]
      link = d[1]
      if d.kind_of?(Array) && name.kind_of?(String) && link.kind_of?(String)
        first_element = first_element + 1
        if first_element == 1
          return_this = link_to name, link
        else
          return_this += ", "
          return_this += link_to name, link
        end
      else
        return_this = ''
        break
      end
    end

    return return_this.html_safe
  end

  def print_partners(data)
    last_element = 0
    return_this = ''
    data.each do |d|
      name = d[0]
      link = d[1]
      image_link = d[2]
      if d.kind_of?(Array) && name.kind_of?(String) && link.kind_of?(String) && image_link.kind_of?(String)
        image = image_tag(image_link, alt: name)
        return_this += '<div class="partner">'
        return_this += link_to image, link, target: 'blank'
        return_this += '</div>'

        last_element = last_element + 1
        if last_element != data.length
          return_this += '<div class="spacer"></div>'
        end
      end
    end

    return return_this.html_safe
  end
end
