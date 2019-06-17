# frozen_string_literal: true

class PusherController < ApplicationController
  # stop rails CSRF protection for this action
  protect_from_forgery except: :auth

  # POST /pusher/auth
  # @argument channel_name [String] The name of the pusher channel.
  # @argument socket_id [String] The id of the pusher socket.
  #
  # Returns an auth token from Pusher that looks like this
  # {"auth": ":7944d5b3dc2915f6a9c55dbedcbe91037799bb3627fc868890c2a7fd6f5fde4b"}
  # 
  # If there is an error, the response will look like this
  # {"channel_name":["can't be blank"],"socket_id":["can't be blank"]}
  def auth
    if current_user
      errors = {}
      errors[:channel_name] = ["can't be blank"] if params[:channel_name].blank?
      errors[:socket_id] = ["can't be blank"] if params[:socket_id].blank?
      
      if errors.empty?
        response = Pusher[params[:channel_name]].authenticate(params[:socket_id])
        render json: response
      else
        render json: errors, status: :bad_request
      end
    else
      render text: t('pusher.not_authorized'), status: '403'
    end
  end
end
