# frozen_string_literal: true

class ProfileController < ApplicationController
  include StoriesHelper

  def index
    # If the specified profile doesn't exist, view the current user's profile
    user = User.find_by(uid: params[:uid])
    user = current_user if user.nil?

    # Determine how the profile should be displayed based on the user_id
    @stories = if user == current_user
                 paginate_stories(current_user)
               elsif current_user.allies_by_status(:accepted).include?(user)
                 paginate_stories(user)
               end

    @profile = user
  end
end
