# frozen_string_literal: true

class ProfileController < ApplicationController
  include StoriesHelper

  def index
    # If the specified profile doesn't exist, view the current user's profile
    user = User.find_by(uid: params[:uid])
    user = current_user if user.nil?

    # Determine how the profile should be displayed based on the user_id
    if user == current_user || current_user.mutual_allies?(user)
      @stories = Kaminari.paginate_array(get_stories(user)).page(params[:page])
    end

    @profile = user
  end
end
