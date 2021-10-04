# frozen_string_literal: true

CRISIS_PREVENTION_TAGS = %w[
  die dead died dying death passed_away kill_myself hurt_myself suicidal suicide
].freeze

class ResourceRecommendations
  def initialize(moment:, current_user:)
    @moment = moment
    @moment_keywords = []
    @current_user = current_user
  end

  def call
    @moment_keywords = MomentKeywords.new(@moment).call
    all_resources.select do |resource|
      resource['tags'].any? do |tag|
        @moment_keywords.match?(tag)
      end
    end
  end

  def matched_tags
    @moment_keywords = MomentKeywords.new(@moment).call

    all_resources.flat_map do |resource|
      resource['tags'].select do |tag|
        @moment_keywords.match?(tag)
      end
    end
  end

  def show_crisis_prevention
    if same_user? && same_date?
      @moment_keywords = MomentKeywords.new(@moment).call

      return CRISIS_PREVENTION_TAGS.any? do |tag|
        @moment_keywords.match?(get_crisis_prevention_tag(tag))
      end
    end

    false
  end

  private

  def get_crisis_prevention_tag(tag)
    I18n.t("pages.resources.crisis_prevention.#{tag}")
  end

  def all_resources
    resources = JSON.parse(File.read('doc/pages/resources.json'))
    resources.each do |item|
      item['tags'].map! { |tag| I18n.t("pages.resources.tags.#{tag}") }
    end
    resources
  end

  def same_user?
    @moment.user_id == @current_user.id
  end

  def same_date?
    @moment.created_at.to_date == Date.current ||
      @moment.updated_at.to_date == Date.current
  end
end
