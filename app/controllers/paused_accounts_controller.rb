# frozen_string_literal: true
class PausedAccountsController < ApplicationController
  # GET /paused_account
  def show
    redirect_to_path(root_path) unless current_user.paused?
  end

  # POST /paused_account
  def create
    current_user.pause!
    sign_out(current_user)
    redirect_to new_user_session_path,
                notice: t('paused_accounts.paused_notice')
  end

  # DELETE /paused_account
  def destroy
    current_user.resume!
    redirect_to root_path, notice: t('paused_accounts.resumed_notice')
  end
end
