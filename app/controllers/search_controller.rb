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
    selected_filters = params[:selected_filters]

    return unless data_type.in?(%w[moment category mood strategy medication])

    redirect_to_path(make_path(term, data_type, selected_filters))
  end

  private

  def search_by_email(email)
    User.where(email:)
        .where.not(id: current_user.id)
        .where.not(banned: true)
  end

  def make_path(term, data_type, selected_filters)
    search_hash = {}
    search_hash[:search] =  term if term.present?
    search_hash[:filters] = selected_filters if selected_filters.present?

    send("#{data_type.pluralize}_path", search_hash)
  end
end
