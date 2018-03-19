# frozen_string_literal: true

class PusherController < ApplicationController
  # stop rails CSRF protection for this action
  protect_from_forgery except: :auth

  def auth
    if current_user
      response = Pusher[params[:channel_name]].authenticate(params[:socket_id])
      render json: response
    else
      render text: t('pusher.not_authorized'), status: '403'
    end
  end
end
