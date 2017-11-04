# frozen_string_literal: true

class LocalesController < ApplicationController
  skip_before_action :if_not_signed_in

  def set_initial_locale
    if current_user
      current_user.update!(locale: params[:locale])
    else
      cookies['locale'] = params[:locale]
    end

    redirect_to root_path
  end
end
