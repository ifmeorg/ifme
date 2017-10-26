# frozen_string_literal: true

class LocalesController < ApplicationController
  skip_before_action :if_not_signed_in

  def set_initial_locale
    cookies["locale"] = params[:locale]
    redirect_to root_path
  end
end
