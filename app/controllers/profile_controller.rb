# frozen_string_literal: true

class ProfileController < ApplicationController
  include StoriesHelper

  def index
    # If the specified profile doesn't exist, view the current user's profile
    user = User.find_by(uid: params[:uid])
    user = current_user if user.nil?

    # Determine how the profile should be displayed based on the user_id
    @stories = if user == current_user
                 Kaminari.paginate_array(get_stories(current_user, false))
                         .page(params[:page])
               elsif current_user.allies_by_status(:accepted).include?(user)
                 Kaminari.paginate_array(get_stories(user, false))
               end

    @profile = user
  end
end
