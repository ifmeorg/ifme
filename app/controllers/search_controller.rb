# frozen_string_literal: true

class SearchController < ApplicationController
  def index
    permitted = params.require(:search).permit(:email)
    raise ActionController::ParameterMissing if permitted.blank?
    @matching_users = search_by_email(permitted[:email].strip)
  rescue ActionController::ParameterMissing
    respond_to do |format|
      format.html { redirect_to allies_path }
      format.json { head :no_content }
    end
  end

  def posts
    data_type = params[:search][:data_type]
    term = params[:search][:name]

    return unless data_type.in?(%w[moment category mood strategy medication])

    respond_to do |format|
      format.html { redirect_to make_path(term, data_type) }
      format.json { head :no_content }
    end
  end

  private

  def search_by_email(email)
    User.where(email: email).where.not(id: current_user.id)
  end

  def make_path(term, data_type)
    send("#{data_type.pluralize}_path", ({ search: term } if term.present?))
  end
end
