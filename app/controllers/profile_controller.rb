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

  def ban_mailer(user, banned)
    return unless user.any?

    if banned
      BannedMailer.add_ban_email(user.first).deliver_now
    else
      BannedMailer.remove_ban_email(user.first).deliver_now
    end
  end

  def ban(banned)
    return unless current_user.admin

    user = User.where(id: params[:user_id]).update(banned: banned)
    ban_mailer(user, banned)
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
