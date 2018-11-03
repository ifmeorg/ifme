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

  def ban_user
    User.where(id: params[:user_id]).update(banned: true)
    redirect_to_path admin_dashboard_path
  end

  def remove_ban
    User.where(id: params[:user_id]).update(banned: false)
    redirect_to_path admin_dashboard_path
  end
end
