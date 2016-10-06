class PagesController < ApplicationController
  include ActionView::Helpers::AssetTagHelper
  helper_method :print_contributors, :print_partners

  def home
    @blurbs = blurbs
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
    @blurbs = blurbs
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
      {name: 'Andy Fry', link: 'https://github.com/andyfry01'},
      {name: 'Yigit Ozkavci', link: 'https://github.com/yigitozkavci'},
      {name: 'Karol Musur', link: 'https://github.com/Wowu'}
    ]

    @contributors.sort_by!{ |c| c[:name].downcase }
  end

  def partners
    @organizations = [
      {
        name: 'Hacker Hours',
        link: 'http://hackerhours.org',
        image_link: '/assets/partners/hacker_hours.png'
      },
      {
        name: 'Open Sourcing Mental Illness',
        link: 'https://osmihelp.org',
        image_link: '/assets/partners/osmi.png'
      },
      {
        name: 'Contributor Convenant',
        link: 'http://contributor-covenant.org',
        image_link: '/assets/partners/contributor_convenant.png'
      },
      {
        name: 'Everybody Has a Brain',
        link: 'http://everybodyhasabrain.com',
        image_link: '/assets/partners/everybody_has_a_brain.png'
      },
      {
        name: 'Brown Sisters Speak',
        link: 'http://brownsistersspeak.org',
        image_link: '/assets/partners/brown_sisters_speak.png'
      },
    ]

    @organizations.sort_by!{ |o| o[:name].downcase }
  end

  def blog
    @posts = [
      {
        link_name: 'Exploring options for help',
        link: 'http://julianguyen.org/exploring-options-for-help/',
        author: 'Julia Nguyen'
      },
      {
        link_name: 'Thoughts on support groups for mental illness',
        link: 'http://julianguyen.org/thoughts-on-support-groups-for-mental-illness/',
        author: 'Julia Nguyen'
      },
      {
        link_name: "Immigrants also have to challenge their own culture's mental health stigma",
        link: 'https://medium.com/aj-global-engagers/immigrants-also-have-to-challenge-their-own-culture-s-mental-health-stigmas-21944ee53f01',
        author: 'Julia Nguyen'
      },
      {
        link_name: 'How do you ignore your OCD compulsions?',
        link: 'http://everybodyhasabrain.tumblr.com/post/117512957629/how-do-you-ignore-ocd-compulsions-its-sort-of',
        author: 'Mark Freeman, Everybody Has a Brain'
      },
      {
        link_name: 'Nail biting and anxiety',
        link: 'http://everybodyhasabrain.tumblr.com/post/60429876832/i-dont-remember-exactly-when-i-started-to-bite-my',
        author: 'Daniela Pichardo, Everybody Has a Brain'
      },
      {
        link_name: 'Opening up your beliefs',
        link: 'http://everybodyhasabrain.tumblr.com/post/111290701414/beliefs-tend-to-change-when-theyre-brought-out',
        author: 'Matt Schroeter, Everybody Has a Brain'
      },
      {
        link_name: 'Undercover Mental Patient Survival Guide',
        link: 'https://medium.com/@rosecheval_74352/stigma-equals-death-7a7d94b638ae#.bor3nudib',
        author: 'Rose Cheval'
      },
      {
        link_name: 'On Depression',
        link: 'https://medium.com/invisible-illness/on-depression-33b3ebf2c7e1#.3l6rjzmb4',
        author: 'Eloisa Guerrero'
      },
      {
        link_name: 'Speaking Her Truth: Q& A with Julia Nguyen founder of if me',
        link: 'http://www.huffingtonpost.com/entry/speaking-her-truth-q-a-with-julia-nguyen-founder_us_57d2bbd3e4b0f831f7071b1e',
        author: 'Myisha T. Hill, Brown Sisters Speak'
      },
      {
        link_name: 'Open Sourcing Mental Health - Part I',
        link: 'http://www.codenewbie.org/podcast/open-sourcing-mental-health-part-i',
        author: 'CodeNewbie Podcast'
      },
      {
        link_name: 'Open Sourcing Mental Health - Part II',
        link: 'http://www.codenewbie.org/podcast/open-sourcing-mental-health-part-ii',
        author: 'CodeNewbie Podcast'
      }
    ]

    @posts.reverse!
  end

  def privacy
  end

  def faq
  end

  def print_contributors(contributors)
    contributors.map do |c|
      if c.kind_of?(Hash) && c[:name].kind_of?(String) && c[:link].kind_of?(String)
        link_to c[:name], c[:link], target: 'blank'
      end
    end.to_sentence.html_safe
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

  private

  def blurbs
    @blurbs = [
      {
        name: 'Julia Nguyen',
        image: '/assets/contributors/julia_nguyen.jpg',
        profile: 'Being open and honest about my journey with obsessive-compulsive disorder, anxiety, and depression helps me to accept myself and reach out for support. My hope is to encourage others to feel more comfortable about sharing their experiences. Growing up as a daughter of Vietnamese refugee parents, it was difficult to talk about mental illness openly. I created if me as a tool to engage loved ones in mental health conversations. Working on the project openly has helped me to further explore my own mental health.',
        location: 'Toronto, Canada',
        link_name: 'julianguyen',
        link: 'http://github.com/julianguyen',
        social: 'github'
      },
      {
        name: 'Jennifer Shen',
        image: '/assets/contributors/jennifer_shen.jpg',
        profile: "I am contributing to if me because one's mental health is often disregarded. It is important that everybody watches and observes how they are feeling on a daily basis, and it is also important that we look out for each other.",
        location: 'Toronto, Canada',
        link_name: 'jzshen',
        link: 'http://github.com/jzshen',
        social: 'github'
      },
      {
        name: 'Jon Tan',
        image: '/assets/contributors/jon_tan.jpg',
        profile: 'Among the millions of web applications, there are only a handful of web applications catering to individuals with mental heatlh. I am glad that Julia has created if me for the purpose of building this community.',
        location: 'Mississauga, Canada',
        link_name: '9bits',
        link: 'http://github.com/9bits',
        social: 'github'
      },
      {
        name: 'Jenny Nguyen',
        image: '/assets/contributors/jenny_nguyen.jpg',
        profile: "As a health science student I have been exposed medical literature that focuses on neuroplasticity, the idea that our environment and actions can change neural circuitry and pathways, and its role in shaping mental health disorders. For example, studies shows the in people with OCD, there is hyperconnectivity between the orbitofrontal cortex and the caudate nucleus, structures of the brain that are responsible for decision-making and thinking. Thus novel treatment of OCD focuses on targeting these principles and beliefs these obsessions and compulsions are founded on in order to rewire the brain. I believe if me provides a platform to habitually reflect and help manage one's wellbeing in addition to formal medical treatment.",
        location: 'Toronto, Canada',
        link_name: 'nguyenjenny',
        link: 'http://github.com/nguyenjenny',
        social: 'github'
      },
      {
        name: 'Srishti Gupta',
        image: '/assets/contributors/srishti_gupta.jpg',
        profile: 'if me is important to me because I see the need for it to exist, because it aims to build support networks for its users and help them grow as individuals and externally be truthful to themselves about what they need to do and when they need to do it, as well as be able to reach out and get advice on how to do things better and can choose to be completely anonymous in the process if they so choose to be. And what makes it even more distinctive is its target audience – because with the stigmas surrounding mental health and various other things, it is very difficult for individuals with mental health concerns to find the right kind of support, because only the individual can determine if something is actually benefitting them. if me allows you to build your own support system and change it as you please which I find very unique, and something everyone should at least give a try, regardless of whether or not  you currently have mental health concerns. I enjoy learning and helping make a meaningful impact, and contributing to if me helps me do that.',
        location: 'Mombasa, Kenya',
        link_name: 'srishtig',
        link: 'http://github.com/srishtig',
        social: 'github'
      },
      {
        name: 'Alex Falconer-Athanassakos',
        image: '/assets/contributors/alex_fa.jpg',
        profile: "People can struggle with their minds despite everything being \"right\" in their lives. People's minds can also give them remarkable resilience through serious adversity. I have been studying for years, in fields from biology to philosophy, to understand this and make a contribution. The internet needs a comprehensive, community-based mental health resource and if me has the kind of people behind it to make it happen.",
        location: 'Toronto, Canada',
        link_name: 'alexfa.net',
        link: 'http://alexfa.net',
        social: 'globe'
      },
      {
        name: 'Gupreet Gill',
        image: '/assets/contributors/gurpreet_gill.jpg',
        profile: 'Being mentally healthy is very important because it not only helps you overcome everyday stress but also makes you more productive and a better contributor. If me allows you to find help and also gives you the opportunity to help others. It ensures that your mental health is in a well-being state by allowing you to share, relate and connect with others. I joined if me because it is a great web application which ensures we all are there for each other.',
        location: 'Brampton, Canada',
        link_name: 'gCrew',
        link: 'http://github.com/gcrew',
        social: 'github'
      },
      {
        name: 'Lucy Yu',
        image: '/assets/contributors/lucy_yu.jpg',
        profile: "The mind is its own place, and in itself can make a heaven of hell, a hell of heaven. — John Milton, Paradise Lost. Our minds are the very screens behind which we perceive the world, yet there is not enough discourse on the importance of sanity. if me is the community I wish existed during my dark times, and I'm hoping to help someone through theirs by contributing to this project.",
        location: 'Mississauga, Canada',
        link_name: 'lucyyu24',
        link: 'https://github.com/lucyyu24',
        social: 'github'
      },
      {
        name: 'Tara Wilkins',
        image: '/assets/contributors/tara_wilkins.jpg',
        profile: "Tara works at the national workshop company #{link_to('Camp Tech', 'http://camptech.ca', target: 'blank')}, where she oversees marketing, runs the day-to-day operations and teaches digital marketing. Outside of her work with Camp Tech, she fosters semi-feral cats with the #{link_to('Annex Cat Rescue', 'http://annexcatrescue.ca', target: 'blank')}, curates creative events for the #{link_to('Makers Digest', 'http://themakersdigest.com', target: 'blank')} and is excited to now be a part of if me. Having personal experiences with mental health herself, Tara is acutely aware of the impact that mental illness can have on lives, families and the workplace. She strongly believes in the power of sharing to erase the stigma and break through barriers. And most of all, she believes in the power of getting help.",
        location: 'Toronto, Canada',
        link_name: 'TaraEWilkins',
        link: 'https://twitter.com/TaraEWilkins',
        social: 'twitter'
      },
      {
        name: 'Darryl Dixon',
        image: '/assets/contributors/darryl_dixon.jpg',
        profile: "As the saying goes: \"You are your own worst enemy.\" Your experience regarding this quote may very, but remember: nothing happens without your brain. Mental health is an important topic of discussion, one that far too many people are afraid to be open about, and far too many don't believe that this is a legitimate concern, resulting in few people finding someone to simply vent to, let alone getting help. The goal of if me is to break that habit, to help others with mental illness find help and a to communicate with their loved ones about their issues.<br><br>Darryl Dixon is a rad cat that loves web development, is a generalist full-stack JavaScript developer, and loves to give back to the community in some way, anywhere.",
        location: 'Virginia, USA',
        link_name: 'PieceDigital.net',
        link: 'https://PieceDigital.net',
        social: 'globe'
      },
      {
        name: 'Nagma Kapoor',
        image: '/assets/contributors/nagma_kapoor.jpg',
        profile: "I have a B.A in Neurobiology from Rutgers University and I am pursuing a 2nd BSc. in Computer Science from Ryerson University. Mental health is a personal topic but good mental health relies on support, and through my interdisciplinary background I hope to bring my unique perspective here. Mental illness has been minimized in my community as a South Asian. You hear stories of family or friends in whispers. Only within my generation onward, there has been a minor shift, and I hope to see it open further. Personally, I have learnt to silently cope and create methods to keep my trajectory towards success without alerting anyone. Which is why I understand the need for an open-source project like if me. Sometimes, you need support from accepting family or friends without the eyes of an entire community on you. I think if me provides us with a safe space that extends out from our own selves and into the few that we trust. Building a closed community, that is free and open to individuals from all backgrounds, is a necessity. Access to mental health and resources need to reach those who need it most, and having an open source platform has been vital for it.",
        location: 'Toronto, Canada',
        link_name: 'nagmak',
        link: 'https://nagmak.github.io/',
        social: 'globe'
      },
      {
        name: 'Bee Martinez',
        image: '/assets/contributors/bee_martinez.jpg',
        profile: "Bee wanted to be a psychologist, became a teacher, and is now a Front-End Developer in training. She loves challenge, creativity, learning, connecting, and helping each other grow.<br><br>Bee thinks the mind is a beautiful and marvelous thing, and as such it should be explored with respect, understood with patience, and treated with kindness.<br><br>In if me, she's found a safe space to combine everything she's ever been passionate about. Her current role is taking over @ifmeorg on weekends and doing Spanish translations.",
        location: 'Texas, USA',
        link_name: 'itsbeemtz',
        link: 'http://twitter.com/itsbeemtz',
        social: 'twitter'
      }
    ]
  end
end
