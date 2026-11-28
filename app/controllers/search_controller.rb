# frozen_string_literal: true

class SearchController < ApplicationController
  include ResourceRouting

  DATA_TYPES = %w[moment category mood strategy medication].freeze

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
    name = params[:search][:name]
    search_filters = params[:search][:filters]

    return unless data_type.in?(DATA_TYPES)

    redirect_to_path(make_path(name, data_type, search_filters))
  end

  private

  def search_by_email(email)
    User.where(email:)
        .where.not(id: current_user.id)
        .where.not(banned: true)
  end

  def make_path(name, data_type, search_filters)
    search_hash = {}
    search_hash[:search] =  name if name.present?
    search_hash[:filters] = search_filters if search_filters.present?

    resource_index_path(data_type, DATA_TYPES, search_hash)
  end
end
