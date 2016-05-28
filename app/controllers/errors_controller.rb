class ErrorsController < ApplicationController
  def not_found
  	@page_title = 'Error'
    render :status => 404
  end

  def internal_server_error
  	@page_title = 'Error'
    render :status => 500
  end
end
