# frozen_string_literal: true

class ErrorsController < ApplicationController
  skip_before_action :if_not_signed_in

  def not_found
    render status: 404
  end

  def internal_server_error
    render status: 500
  end
end
