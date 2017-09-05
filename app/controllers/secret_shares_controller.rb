# frozen_string_literal: true

class SecretSharesController < ApplicationController

  skip_before_action :if_not_signed_in, only: [:show]

  def create
    raise ActiveRecord::RecordNotFound unless Rails.configuration.secret_share_enabled
    #Authorisation check will automatically raise ActiveRecord::RecordNotFound
    moment = Moment.where(userid: current_user.id).friendly.find(params[:moment])
    moment.update!(secret_share_identifier: SecureRandom.uuid, secret_share_expires_at: 1.day.from_now)
    redirect_to moment_path(moment)
  end

  def show
    raise ActiveRecord::RecordNotFound unless Rails.configuration.secret_share_enabled
    @moment = Moment.find_secret_share!(params[:id])
    render 'moments/show'
  end

  def destroy
    raise ActiveRecord::RecordNotFound unless Rails.configuration.secret_share_enabled
    moment = Moment.find_by!(userid: current_user.id, secret_share_identifier: params[:id])
    moment.update!(secret_share_identifier: nil)
    redirect_to moment_path(moment)
  end
end
