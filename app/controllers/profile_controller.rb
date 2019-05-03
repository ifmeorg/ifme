# frozen_string_literal: true

class ProfileController < ApplicationController
  include ProfileHelper

  def index
    setup_stories
  end

  def data
    setup_stories
    respond_to do |format|
      format.json do
        render json: data_json
      end
    end
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
