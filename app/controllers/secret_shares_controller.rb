# frozen_string_literal: true

class SecretSharesController < ApplicationController
  skip_before_action :if_not_signed_in, only: [:show]

  def create
    # Authorisation check will automatically raise ActiveRecord::RecordNotFound
    moment = Moment.where(user: current_user).friendly.find(params[:moment])
    moment.update!(
      secret_share_identifier: SecureRandom.uuid,
      secret_share_expires_at: 1.day.from_now
    )
    redirect_to moment_path(moment, anchor: 'secretShare')
  end

  def show
    @moment = Moment.find_secret_share!(params[:id])
    @page_author = User.find(@moment.user_id)
    render 'moments/show'
  end

  def destroy
    moment = Moment.find_by!(user: current_user, id: params[:id])
    moment.update!(secret_share_identifier: nil)
    redirect_to moment_path(moment)
  end
end
