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
      {name: 'Elizabeth Mitchell', link: 'https://github.com/emitche'},
      {name: 'William Horton', link: 'https://github.com/wdhorton'},
      {name: 'Bella Woo', link: 'https://github.com/bellawoo'},
      {name: 'Julie Pagano', link: 'https://github.com/juliapagano'},
      {name: 'Fiona Conn', link: 'https://github.com/fpcyan'},
      {name: 'Iuliia Kotlenko', link: 'https://github.com/IuliiaKot'},
      {name: 'Daniel Levenson', link: 'https://github.com/dleve123'},
      {name: 'Dawa Sherpa', link: 'https://github.com/Dawa12'},
      {name: 'Tien Yuan', link: 'https://github.com/tienyuan'},
      {name: 'chenghw', link: 'https://github.com/chenghw'},
      {name: 'Danny Burgoyne', link: 'https://github.com/dburgoyne'},
      {name: 'Jellene Khoh', link: 'https://github.com/jellene4eva'},
      {name: 'John Lim', link: 'https://github.com/jolim24601'},
      {name: 'Danny Glatstein', link: 'https://github.com/danielglatstein'},
      {name: 'Tess Gadwa', link: 'http://www.yesexactly.com'},
      {name: 'Mark Farrell', link: 'https://github.com/markfarrell'},
      {name: 'Laura Evans', link: 'https://github.com/lksevans12'},
      {name: 'Christopher De Borja', link: 'https://github.com/cdeborja'},
      {name: 'Dominic Prescod', link: 'https://github.com/dominicprescod'},
      {name: 'Noah Finnerman', link: 'https://github.com/nonothetoad'},
      {name: 'David Tomberlin', link: 'https://github.com/siyegen'},
      {name: 'Elana Hashman', link: 'https://github.com/ehashman'},
      {name: 'Caleb Thompson', link: 'https://github.com/calebthompson'},
      {name: 'Stella Cotton', link: 'https://github.com/stellacotton'},
      {name: 'Karen Kelley', link: 'https://github.com/kkelleey'},
      {name: 'Gwen Weston', link: 'https://github.com/gwengrid'},
      {name: 'Mark Freeman', link: 'http://markfreeman.ca'},
      {name: 'Catherine Vendryes', link: 'http://catherinevendryes.com'},
      {name: 'Michelle Liauw', link: 'https://github.com/techiemichelle'},
      {name: 'Kerry Benjamin', link: 'https://twitter.com/kerry_benjamin1'},
      {name: 'Sylvia Pereira', link: 'https://github.com/sylviapereira'},
      {name: 'Jonathan Garnaas-Holmes', link: 'https://github.com/finitem'},
      {name: 'Rashmi Agarwal', link: 'https://github.com/rashmiagar'},
      {name: 'Nicolette Chambers', link: 'https://github.com/nchambe2'},
      {name: 'Siena Aguayo', link: 'https://github.com/sienatime'},
      {name: 'Łukasz Domański', link: 'https://github.com/maestromusica'},
      {name: 'SashaTlr', link: 'https://github.com/SashaTlr'},
      {name: 'Jon Friestedt', link: 'https://github.com/jfriestedt'},
      {name: 'Andy Fry', link: 'https://github.com/andyfry01'}
    ]

    @contributors.sort_by!{ |c| c[:name].downcase }

    @organizations = [
      {name: 'Hacker Hours', link: 'http://hackerhours.org', image_link: '/assets/partners/hacker_hours.png'},
      {name: 'Open Sourcing Mental Illness', link: 'https://osmihelp.org', image_link: '/assets/partners/osmi.png'},
      {name: 'Contributor Convenant', link: 'http://contributor-covenant.org', image_link: '/assets/partners/contributor_convenant.png'},
      {name: 'Everybody Has a Brain', link: 'http://everybodyhasabrain.com', image_link: '/assets/partners/everybody_has_a_brain.png'},
      {name: 'Brown Sisters Speak', link: 'http://brownsistersspeak.org', image_link: '/assets/partners/brown_sisters_speak.png'},
    ]

    @organizations.sort_by!{ |o| o[:name].downcase }
  end

  def blog
    @posts = [
      {link_name: 'Exploring options for help', link: 'http://julianguyen.org/exploring-options-for-help/', author: 'Julia Nguyen'},
      {link_name: 'Thoughts on support groups for mental illness', link: 'http://julianguyen.org/thoughts-on-support-groups-for-mental-illness/', author: 'Julia Nguyen'},
      {link_name: "Immigrants also have to challenge their own culture's mental health stigma", link: 'https://medium.com/aj-global-engagers/immigrants-also-have-to-challenge-their-own-culture-s-mental-health-stigmas-21944ee53f01', author: 'Julia Nguyen'},
      {link_name: 'How do you ignore your OCD compulsions?', link: 'http://everybodyhasabrain.tumblr.com/post/117512957629/how-do-you-ignore-ocd-compulsions-its-sort-of', author: 'Mark Freeman, Everybody Has a Brain'},
      {link_name: 'Nail biting and anxiety', link: 'http://everybodyhasabrain.tumblr.com/post/60429876832/i-dont-remember-exactly-when-i-started-to-bite-my', author: 'Daniela Pichardo, Everybody Has a Brain'},
      {link_name: 'Opening up your beliefs', link: 'http://everybodyhasabrain.tumblr.com/post/111290701414/beliefs-tend-to-change-when-theyre-brought-out', author: 'Matt Schroeter, Everybody Has a Brain'},
      {link_name: 'Undercover Mental Patient Survival Guide', link: 'https://medium.com/@rosecheval_74352/stigma-equals-death-7a7d94b638ae#.bor3nudib', author: 'Rose Cheval'},
      {link_name: 'On Depression', link: 'https://medium.com/invisible-illness/on-depression-33b3ebf2c7e1#.3l6rjzmb4', author: 'Eloisa Guerrero'},
      {link_name: 'Speaking Her Truth: Q& A with Julia Nguyen founder of if me', link: 'http://www.huffingtonpost.com/entry/speaking-her-truth-q-a-with-julia-nguyen-founder_us_57d2bbd3e4b0f831f7071b1e', author: 'Myisha T. Hill, Brown Sisters Speak'}
    ]

    @posts.reverse!
  end

  def privacy
  end

  def faq
  end

  def print_contributors(data)
    return_this = ''
    data.each_with_index do |d, index|
      if d.kind_of?(Hash) && d[:name].kind_of?(String) && d[:link].kind_of?(String)
        if data.length > 2 && index + 1 == data.length
          return_this += ", and "
        elsif index != 0
          return_this += ", "
        end
        return_this += link_to d[:name], d[:link], target: 'blank'
      else
        break
      end
    end

    return return_this.html_safe
  end

  def print_partners(data)
    return_this = ''
    data.each_with_index do |d, index|
      if d.kind_of?(Hash) && d[:name].kind_of?(String) && d[:link].kind_of?(String) && d[:image_link].kind_of?(String)
        image = image_tag(d[:image_link], alt: d[:name])
        return_this += '<div class="partner">'
        return_this += link_to image, d[:link], target: 'blank'
        return_this += '</div>'

        if index + 1 != data.length
          return_this += '<div class="spacer"></div>'
        end
      else
        break
      end
    end

    return return_this.html_safe
  end
end
