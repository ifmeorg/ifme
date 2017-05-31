class PagesController < ApplicationController
  skip_before_filter :if_not_signed_in

  def home
    @blurbs = set_blurbs
    if user_signed_in?
      @stories = Kaminari.paginate_array(get_stories(current_user, true))
                         .page(params[:page])

      load_dashboard_data if !@stories.blank? && @stories.count.positive?
    else
      @posts = set_posts
    end
  end

  def blog
    @posts = set_posts
  end

  def contributors
    @blurbs = set_blurbs
    @contributors = set_contributors
  end

  def partners
    @organizations = set_organizations
  end

  def toggle_locale
    if user_signed_in?
      toggle_when_signed_in(params[:locale])
    else
      render json: { signed_out: true }
    end
  end

  def about; end

  def faq; end

  def privacy; end

  private

  def toggle_when_signed_in(locale)
    user = User.find(current_user)
    if !locale && user || locale == user.locale
      render json: { signed_in_no_reload: user.locale }
    else
      user.update!(locale: locale)
      render json: { signed_in_reload: locale }
    end
  end

  def load_dashboard_data
    params = { userid: current_user.id }

    @moment = Moment.new
    @categories = Category.where(params).order(created_at: :desc)
    @moods = Mood.where(params).order(created_at: :desc)
  end

  def set_organizations
    organizations = JSON.parse(File.read('doc/contributors/partners.json'))
    organizations.sort_by! { |o| o['name'].downcase }
  end

  def set_contributors
    contributors = JSON.parse(File.read('doc/contributors/contributors.json'))
    contributors.sort_by! { |c| c['name'].downcase }
  end

  def set_blurbs
    JSON.parse(File.read('doc/contributors/blurbs.json'))
  end

  def parse_author(post)
    author = ''
    if post[1]['previewContent']['bodyModel']['paragraphs'][1]
      author = post[1]['previewContent']['bodyModel']['paragraphs'][1]['text']
    end
    author
  end

  def fetch_posts
    medium = Medium.new
    posts = []
    medium.posts.each do |post|
      posts.push(
        'link_name' => post[1]['title'],
        'link' => "https://medium.com/ifme/#{post[1]['uniqueSlug']}",
        'author' => parse_author(post)
      )
    end
    posts
  end

  def set_posts
    non_medium_posts = JSON.parse(File.read('doc/contributors/posts.json'))
    fetch_posts.concat(non_medium_posts.reverse)
  end
end
