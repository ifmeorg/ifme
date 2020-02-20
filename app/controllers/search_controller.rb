# frozen_string_literal: true

class SearchController < ApplicationController
  def index
    permitted = params.require(:search).permit(:email)
    raise ActionController::ParameterMissing if permitted.blank?

    @matching_users = search_by_email(permitted[:email].strip)
    @email_query = permitted[:email]
  rescue ActionController::ParameterMissing
    redirect_to_path(allies_path)
  end

  def posts
    data_type = params[:search][:data_type]
    term = params[:search][:name]

    return unless data_type.in?(%w[moment category mood strategy medication])

    redirect_to_path(make_path(term, data_type))
  end

  private

  def search_by_email(email)
    User.where(email: email).where.not(id: current_user.id, banned: true)
  end

  def make_path(term, data_type)
    send("#{data_type.pluralize}_path", ({ search: term } if term.present?))
  end
end
