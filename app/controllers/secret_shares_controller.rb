# frozen_string_literal: true

class SecretSharesController < ApplicationController

  skip_before_action :if_not_signed_in, only: [:show]

  def create
    #need to add an authorisation check here
    moment = Moment.friendly.find(params[:moment])
    moment.update!(secret_share_identifier: SecureRandom.uuid)
    redirect_to moment_path(moment)
  end

  def show
    @moment = Moment.find_by(secret_share_identifier: params[:id])
    render 'moments/show'
  end

end
