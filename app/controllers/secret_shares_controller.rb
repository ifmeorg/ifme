class SecretSharesController < ApplicationController

  def create
    moment = Moment.friendly.find(params[:moments])
    moment.update!(secret_share_identifier: SecureRandom.uuid)
    redirect_to moment_path(moment)
  end

end
