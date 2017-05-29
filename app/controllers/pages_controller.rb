class PagesController < ApplicationController
  before_action :set_blurbs, only: [:contributors, :home]
  skip_before_filter :if_not_signed_in

  def home
    if user_signed_in?
      @stories = Kaminari.paginate_array(get_stories(current_user, true))
                         .page(params[:page])

      load_dashboard_data if !@stories.blank? && @stories.count.positive?
    else
      @posts = fetch_medium_posts
    end
  end

  def blog
    @posts = fetch_medium_posts
    non_medium_posts = JSON.parse(File.read('doc/contributors/posts.json'))
    @posts.concat(non_medium_posts.reverse)
  end

  def contributors
    @contributors = JSON.parse(File.read('doc/contributors/contributors.json'))
    @contributors.sort_by! { |c| c['name'].downcase }
  end

  def partners
    @organizations = JSON.parse(File.read('doc/contributors/partners.json'))
    @organizations.sort_by! { |o| o['name'].downcase }
  end

  def about; end

  def faq; end

  def privacy; end

  private

  def set_blurbs
    @blurbs = JSON.parse(File.read('doc/contributors/blurbs.json'))
  end

  def load_dashboard_data
    params = { userid: current_user.id }

    @moment = Moment.new
    @categories = Category.where(params).order(created_at: :desc)
    @moods = Mood.where(params).order(created_at: :desc)
  end

  def fetch_medium_posts
    medium = Medium.new
    posts = Array.new
    medium.posts.each do |post|
      author = ''
      if (post[1]['previewContent']['bodyModel']['paragraphs'][1])
        author = post[1]['previewContent']['bodyModel']['paragraphs'][1]['text']
      end
      posts.push({
        'link_name' => post[1]['title'],
        'link' => "https://medium.com/ifme/#{post[1]['uniqueSlug']}",
        'author' => author
      })
    end
    posts
  end
end
