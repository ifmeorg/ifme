# frozen_string_literal: true
module TagsHelper
  include MomentsHelper

  def tagged_moments_data_json
    { data: moments_or_strategy_props(@moments),
      lastPage: @moments.last_page? }
  end

  def tagged_strategies_data_json
    { data: moments_or_strategy_props(@strategies),
      lastPage: @strategies.last_page? }
  end

  def setup_stories
    set_tags
    return unless viewable_tag?(@category) || viewable_tag?(@mood) ||
                  viewable_tag?(@strategy)

    @moments = fetch_moments
    @strategies = fetch_strategies
  end

  private

  def set_tags
    @category = Category.find(params[:category_id]) if params[:category_id]
    @mood = Mood.find(params[:mood_id]) if params[:mood_id]
    @strategy = Strategy.find(params[:strategy_id]) if params[:strategy_id]
  end

  def fetch_moments
    data = get_tagged_data(
      @category || @mood || @strategy,
      User.find_by(id: current_user.id).moments.recent
    )
    return unless data

    @total_moments = data[:total]
    data[:posts]
  end

  def fetch_strategies
    data = get_tagged_data(
      @category, User.find_by(id: current_user.id).strategies.recent
    )
    return unless data

    @total_strategies = data[:total]
    data[:posts]
  end

  def viewable_tag?(data)
    return false unless data&.respond_to?(:user_id)

    data.user_id == current_user.id ||
      (data.try(:viewers)&.include?(current_user.id) &&
        data.published?)
  end

  def get_total(result)
    total = 0
    total_pages = Kaminari.paginate_array(result).page(1).total_pages
    total_pages.times do |i|
      total += Kaminari.paginate_array(result).page(i + 1).count
    end
    total
  end

  def get_tagged_data(tag, data)
    return unless tag && data

    result = if tag.is_a?(Mood)
               get_moods_from_data(data, tag.id)
             else
               get_attribute_from_data(data, tag)
             end
    { total: get_total(result),
      posts: Kaminari.paginate_array(result).page(params[:page]) }
  end

  def get_moods_from_data(data, mood_id)
    data.select { |d| d.moods.include?(mood_id) }
  end

  def get_attribute_from_data(data, tag)
    attribute = tag.class.name.downcase
    data.select { |d| d if d.send(attribute).include?(tag.id) }
  end
end
