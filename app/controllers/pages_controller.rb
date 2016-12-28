class PagesController < ApplicationController
  before_action :set_blurbs, only: [:contributors, :home]
  skip_before_filter :if_not_signed_in

  def home
    if user_signed_in?
      @stories = Kaminari.paginate_array(get_stories(current_user, true))
                         .page(params[:page])

      load_dashboard_data if !@stories.blank? && @stories.count.positive?
    end
  end

  def blog
    @posts = JSON.parse(File.read('doc/contributors/posts.json'))
    @posts.reverse!
  end

  def letsencrypt
    challenges = ENV['LETSENCRYPT_CHALLENGE'].try(:split, ',') || []
    mappings = Hash[challenges.collect { |v| [v.split('.')[0], v] }]

    if mappings.key?(params[:id])
      render text: mappings[params[:id]]
    else
      render text: 'Unknown id.'
    end
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
end
