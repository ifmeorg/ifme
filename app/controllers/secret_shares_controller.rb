# frozen_string_literal: true

class SecretSharesController < ApplicationController

  skip_before_action :if_not_signed_in, only: [:show]

  def create
    #need to add an authorisation check here
    moment = Moment.friendly.find(params[:moment])
    moment.update!(secret_share_identifier: SecureRandom.uuid, secret_share_expires_at: 1.day.from_now)
    redirect_to moment_path(moment)
  end

  def show
    @moment = Moment.find_by(secret_share_identifier: params[:id])
    if Time.now < @moment.secret_share_expires_at
      #expiry may be after 30mins, to discuss.
      render 'moments/show'
    else
      raise ActiveRecord::RecordNotFound
    end
  end

  def delete
    moment = Moment.friendly.find(params[:moment])
    moment.update!(secret_share_identifier: nil)
    redirect_to moment_path(moment)
  end

end
