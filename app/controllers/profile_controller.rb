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
    ban_or_remove(true)
  end

  def remove_ban
    ban_or_remove(false)
  end

  private

  def ban_or_remove(banned)
    user = User.where(id: params[:user_id]).update(banned: banned)
    redirect_to(
      admin_dashboard_path,
      notice_or_alert(
        user,
        banned ? 'user_banned' : 'ban_removed'
      )
    )
  end

  def notice_or_alert(user, notice)
    name = user&.first&.name || params[:user_id]
    return { alert: t("reports.#{notice}_error", name: name) } unless user.any?

    { notice: t("reports.#{notice}", name: name) }
  end
end
