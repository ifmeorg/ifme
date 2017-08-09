# frozen_string_literal: true

class SecretSharesController < ApplicationController

  skip_before_action :if_not_signed_in, except: :create

  def create
    moment = Moment.friendly.find(params[:moment])
    moment.update!(secret_share_identifier: SecureRandom.uuid)
    redirect_to moment_path(moment)
  end

  def show
  end

end
