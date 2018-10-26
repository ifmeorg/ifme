# frozen_string_literal: true

class ProfileController < ApplicationController
  include StoriesHelper

  def index
    user = User.find_by(uid: params[:uid])
    @profile = user
    return unless user == current_user || current_user.mutual_allies?(user)

    @stories = Kaminari.paginate_array(get_stories(user))
                       .page(params[:page])
  end
end
