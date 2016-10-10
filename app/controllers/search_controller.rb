class SearchController < ApplicationController
  def index
    mail = params[:search][:email]

    @matching_users = User.where.not(id: current_user.id).all
    @matching_users = @matching_users.where(email: mail.strip) if mail.present?
  end

  def posts
    data_type = params[:search][:data_type]
    term = params[:search][:name]

    if %w(moment category mood strategy medication).include? data_type
      respond_to do |format|
        format.html { redirect_to make_path(term, data_type) }
        format.json { head :no_content }
      end
    end
  end

  private

  def make_path(term, data_type)
    send("#{data_type.pluralize}_path", ({ search: term } if term.present?))
  end

  def if_not_signed_in
    if !user_signed_in?
      respond_to do |format|
        format.html { redirect_to new_user_session_path }
        format.json { head :no_content }
      end
    end
  end
end
