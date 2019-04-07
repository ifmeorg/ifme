# frozen_string_literal: true
module PagesConcern
  extend ActiveSupport::Concern

  def load_dashboard_data
    params = { user_id: current_user.id }

    @moment = Moment.new
    @categories = Category.where(params).order(created_at: :desc)
    @moods = Mood.where(params).order(created_at: :desc)
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
