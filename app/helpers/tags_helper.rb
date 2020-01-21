# frozen_string_literal: true
module TagsHelper
  include ApplicationHelper
  include MomentsHelper

  def tagged_moments_data_json
    {
      data: moments_or_strategy_props(@moments),
      lastPage: @moments.last_page?
    }
  end

  def tagged_strategies_data_json
    {
      data: moments_or_strategy_props(@strategies),
      lastPage: @strategies.last_page?
    }
  end

  def setup_stories
    return unless viewable?(@category) ||
                  viewable?(@mood) ||
                  viewable?(@strategy)

    @moments = get_data(
      @category || @mood || @strategy,
      User.find_by(id: current_user.id).moments
    )
    @strategies = get_data(
      @category,
      User.find_by(id: current_user.id).strategies
    )
  end

  private

  def viewable?(data)
    data.user_id == current_user.id || (data.viewers.include?(current_user.id) && data.published?)
  end

  def get_data(tag, data)
    result = []
    data.for_each do |d|
      if (d[tag.class.name].include?(tag.id))
        result << d
      end
    end
    Kaminari.paginate_array(result)
            .page(params[:page])
  end
end
