# frozen_string_literal: true

class SearchController < ApplicationController
  def index
    mail = params[:search][:email]

    @matching_users = User.where.not(id: current_user.id).all
    @matching_users = @matching_users.where(email: mail.strip) if mail.present?
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

  def make_path(term, data_type)
    send("#{data_type.pluralize}_path", ({ search: term } if term.present?))
  end
end
