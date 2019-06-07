# frozen_string_literal: true

class PusherController < ApplicationController
  # stop rails CSRF protection for this action
  protect_from_forgery except: :auth

  # POST /pusher/auth
  #
  # Returns an auth token from Pusher that looks like this
  # {:auth=>":7944d5b3dc2915f6a9c55dbedcbe91037799bb3627fc868890c2a7fd6f5fde4b"}
  def auth
    if current_user
      response = Pusher[params[:channel_name]].authenticate(params[:socket_id])
      render json: response
    else
      render text: t('pusher.not_authorized'), status: '403'
    end
  end
end
