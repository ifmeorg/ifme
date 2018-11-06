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

  def add_ban
    ban(true)
  end

  def remove_ban
    ban(false)
  end

  private

  def update_and_email(user, banned)
    user.update(banned: banned)
    if banned
      BannedMailer.add_ban_email(user).deliver_now
    else
      BannedMailer.remove_ban_email(user).deliver_now
    end
  end

  def ban(banned)
    return unless current_user.admin

    user = User.find_by(id: params[:user_id])
    update_and_email(user, banned) if user.present?
    redirect_to(
      admin_dashboard_path,
      notice_or_alert(
        user,
        banned ? 'user_banned' : 'ban_removed'
      )
    )
  end

  def notice_or_alert(user, notice)
    name = user&.name || params[:user_id]
    return { notice: t("reports.#{notice}", name: name) } if user.present?

    { alert: t("reports.#{notice}_error", name: name) }
  end
end
