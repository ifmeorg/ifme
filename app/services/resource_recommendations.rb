# frozen_string_literal: true

CRISIS_PREVENTION_TAGS = %w[
  die dead died dying death passed_away kill_myself hurt_myself suicidal suicide
  want_to_die end_my_life take_my_life end_it_all self_harm
  no_reason_to_live not_worth_living overdose
].freeze

class ResourceRecommendations
  def initialize(moment:, current_user:)
    @moment = moment
    @moment_keywords = []
    @current_user = current_user
  end

  def call
    @moment_keywords = MomentKeywords.new(@moment).call
    @history_keywords = user_history_keywords

    all_resources
      .map { |r| [r, resource_score(r)] }
      .select { |_, score| score > 0 }
      .sort_by { |_, score| -score }
      .map { |r, _| r }
  end

  def matched_tags
    @moment_keywords = MomentKeywords.new(@moment).call

    all_resources.flat_map do |resource|
      resource['tags'].select { |tag| @moment_keywords.match?(tag) }
    end
  end

  def show_crisis_prevention
    if same_user? && same_date?
      return has_crisis_keywords?
    end

    false
  end

  def has_crisis_keywords?
    @moment_keywords = MomentKeywords.new(@moment).call
    CRISIS_PREVENTION_TAGS.any? do |tag|
      @moment_keywords.match?(get_crisis_prevention_tag(tag))
    end
  end

  private

  def resource_score(resource)
    resource['tags'].sum do |tag|
      score = 0
      score += 2 if @moment_keywords.match?(tag)
      score += 1 if @history_keywords.match?(tag)
      score
    end
  end

  def user_history_keywords
    return '' unless @current_user

    recent_moment_ids = @current_user.moments
      .where(created_at: 90.days.ago..)
      .pluck(:id)
    return '' if recent_moment_ids.empty?

    top_moods = Mood.joins(:moments_moods)
      .where(moments_moods: { moment_id: recent_moment_ids })
      .group('moods.id')
      .order('COUNT(moods.id) DESC')
      .limit(5)
      .pluck(:name, :description)
      .flatten
      .compact

    top_categories = Category.joins(:moments_categories)
      .where(moments_categories: { moment_id: recent_moment_ids })
      .group('categories.id')
      .order('COUNT(categories.id) DESC')
      .limit(5)
      .pluck(:name, :description)
      .flatten
      .compact

    (top_moods + top_categories)
      .join(' ')
      .downcase
      .gsub(/[^\p{Alpha} -]/, '')
  end

  def get_crisis_prevention_tag(tag)
    I18n.t("pages.resources.crisis_prevention.#{tag}")
  end

  def all_resources
    resources = JSON.parse(File.read('doc/pages/resources.json'))
    resources.each do |item|
      item['tag_keys'] = item['tags'].dup
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
