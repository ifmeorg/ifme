class PagesController < ApplicationController
  before_action :set_blurbs, only: [:contributors, :home]
  skip_before_filter :if_not_signed_in

  def home
    if user_signed_in?
      @stories = Kaminari.paginate_array(get_stories(current_user, true))
                         .page(params[:page]).per($per_page)

      if !@stories.blank? && @stories.count.positive?
        @moment = Moment.new
        params = { userid: current_user.id }
        @categories = Category.where(params).order(created_at: :desc)
        @moods = Mood.where(params).order(created_at: :desc)
      end
    end
  end

  def about; end

  def contributors
    @contributors = JSON.parse(File.read('doc/contributors/contributors.json'))
    @contributors.sort_by! { |c| c['name'].downcase }
  end

  def partners
    @organizations = JSON.parse(File.read('doc/contributors/partners.json'))
    @organizations.sort_by! { |o| o['name'].downcase }
  end

  def blog
    @posts = JSON.parse(File.read('doc/contributors/posts.json'))
    @posts.reverse!
  end

  def privacy; end

  def faq; end

  private

  def set_blurbs
    @blurbs = JSON.parse(File.read('doc/contributors/blurbs.json'))
  end
end
