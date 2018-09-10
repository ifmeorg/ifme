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
    ban_user_id = params[:ban_user_id]
    User.where(id: ban_user_id).update(banned: true)
    redirect_to admin_dashboard_reports_path
  end  

  def remove_ban
    ban_user_id = params[:ban_user_id]
    User.where(id: ban_user_id).update(banned: false)
    redirect_to admin_dashboard_reports_path
  end
end
