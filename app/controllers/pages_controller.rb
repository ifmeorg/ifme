# frozen_string_literal: true

class PagesController < ApplicationController
  include StoriesHelper
  include MomentsHelper
  include PagesHelper
  include PagesConcern

  skip_before_action :if_not_signed_in, except: %i[home_data]
  before_action :if_not_signed_in, only: %i[home_data]

  before_action :if_not_admin, only: %i[admin_dashboard]

  def home
    if user_signed_in?
      setup_stories
      load_dashboard_data if @stories.present? && @stories.count.positive?
    else
      @blurbs = set_blurbs
      @posts = fetch_posts
    end
  end

  def home_data
    setup_stories
    respond_to do |format|
      format.json do
        render json: home_data_json if @stories
      end
    end
  end

  def partners
    @organizations = set_organizations
  end

  def toggle_locale
    if !user_signed_in? ||
       (user_signed_in? && current_user.locale != params[:locale] &&
        current_user.update(locale: params[:locale]))
      render json: {}, status: :ok
    else
      render json: {}, status: :bad_request
    end
  end

  def press
    @press = set_press
  end

  def resources
    @resources = fetch_resources
    @keywords = filter_keywords
  end

  def about
    @blurbs = set_blurbs
    @contributors = set_contributors
  end

  def admin_dashboard
    @reports = Report.order('created_at DESC').all
    @banned_users = User.where(banned: true)
  end

  def faq; end

  def privacy; end

  private

  def filter_keywords
    return [] if params[:filter].nil? || !params[:filter].is_a?(Array)

    word_tags.select { |r| params[:filter].map(&:downcase).include? r.downcase }
  end

  def word_tags
    @resources.reduce([]) do |arr, resource|
      locations = resource['locations'] || []
      arr + resource['tags'] + resource['languages'] + locations
    end.uniq
  end

  def set_organizations
    organizations = JSON.parse(File.read('doc/pages/partners.json'))
    organizations.sort_by! { |o| o['name'].downcase }
  end

  def set_contributors
    contributors = JSON.parse(File.read('doc/pages/contributors.json'))
    contributors.sort_by! { |c| c['name'].downcase }
  end

  def set_blurbs
    JSON.parse(File.read('doc/pages/blurbs.json'))
  end

  def parse_author(post)
    post['author']
  end

  def fetch_posts
    medium_posts = Medium.new.posts
    posts = []
    medium_posts.each do |post|
      posts.push(
        link_name: post['title'],
        link: post['link'],
        author: parse_author(post)
      )
    end
    posts
  end

  def set_press
    JSON.parse(File.read('doc/pages/press.json')).reverse
  end
end
