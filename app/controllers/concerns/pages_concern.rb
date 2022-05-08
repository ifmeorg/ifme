# frozen_string_literal: true
module PagesConcern
  extend ActiveSupport::Concern

  def load_dashboard_data
    params = { user_id: current_user.id }

    @moment = Moment.new
    @categories = Category.where(params).order(created_at: :desc)
    @moods = Mood.where(params).order(created_at: :desc)
  end

  def modify_resources
    resources = JSON.parse(File.read('doc/pages/resources.json'))
    resources.each do |item|
      pr = 'pages.resources'
      item['tags'].map! { |tag| t("#{pr}.tags.#{tag}") }
      item['languages'].map! { |language| t("languages.#{language}") }
      item['locations']&.map! { |location| t("#{pr}.locations.#{location}") }
      item['tags'].sort_by!(&:downcase)
      item['languages'].sort_by!(&:downcase)
      item['locations']&.sort_by! { |location| location.downcase }
    end
    resources
  end

  def fetch_resources
    modify_resources.sort_by! { |r| r['name'].downcase }
  end
end
