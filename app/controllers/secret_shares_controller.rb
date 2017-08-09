class SecretSharesController < ApplicationController

  def create
    moment = Moment.find(params[:moment])
    moment.update!(secret_share_identifier: SecureRandom.uuid)
    redirect_to moment_path(moment)
  end
end
