# frozen_string_literal: true

class PagesController < ApplicationController
  include StoriesHelper

  skip_before_action :if_not_signed_in

  def home
    @blurbs = set_blurbs
    if user_signed_in?
      @stories = Kaminari.paginate_array(get_stories(current_user, true))
                         .page(params[:page])

      load_dashboard_data if @stories.present? && @stories.count.positive?
    else
      @posts = fetch_posts
    end
  end

  def contribute
    @blurbs = set_blurbs
    @contributors = set_contributors
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
  end

  def about; end

  def faq; end

  def privacy; end

  private

  def load_dashboard_data
    params = { user_id: current_user.id }

    @moment = Moment.new
    @categories = Category.where(params).order(created_at: :desc)
    @moods = Mood.where(params).order(created_at: :desc)
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
    post[1]['content']['subtitle'] || ''
  end

  def fetch_posts
    medium = Medium.new
    posts = []
    medium.posts.each do |post|
      posts.push(
        link_name: post[1]['title'],
        link: "https://medium.com/ifme/#{post[1]['uniqueSlug']}",
        author: parse_author(post)
      )
    end
    posts
  end

  def set_press
    JSON.parse(File.read('doc/pages/press.json')).reverse
  end

  def modify_resources(resource_type)
    resources = JSON.parse(File.read("doc/pages/#{resource_type}.json"))
    resources.each do |item|
      item['type'] = t("pages.resources.#{resource_type}")
      item['tags'].map! { |tag| t("pages.resources.tags.#{tag}") }
      item['languages'].map! { |language| t("languages.#{language}") }
    end
    resources
  end

  def fetch_resources
    new_resources = []
    resource_types = %w[communities education hotlines services]
    resource_types.each do |resource_type|
      new_resources += modify_resources(resource_type)
    end
    new_resources.sort_by! { |r| r['name'].downcase }
  end
end
