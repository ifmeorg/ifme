# frozen_string_literal: true

module ProfileHelper
  include ApplicationHelper
  include StoriesHelper
  include MomentsHelper

  def data_json
    {
      data: moments_or_strategy_props(@stories),
      lastPage: @stories.last_page?
    }
  end

  def setup_stories
    if current_user.uid == params[:uid]
      @profile = current_user
    else
      @profile = User.find_by(uid: params[:uid])
    end

    return unless @profile == current_user ||
                  current_user.mutual_allies?(@profile)

    @stories = Kaminari.paginate_array(get_stories(@profile))
                       .page(params[:page])
  end
end
