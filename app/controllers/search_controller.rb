class SearchController < ApplicationController
  before_filter :if_not_signed_in

  def index
    mail = params[:search][:email]

    @matching_users = User.where.not(id: current_user.id).all
    @matching_users = @matching_users.where(email: mail.strip) if mail.present?
  end

  def posts
    data_type = params[:search][:data_type]
    term = params[:search][:name]

    search = { search: term } if term.present?
    path = send("#{data_type.pluralize}_path", search)

    respond_to do |format|
      format.html { redirect_to path }
      format.json { head :no_content }
    end
  end

  private

  def if_not_signed_in
    if !user_signed_in?
      respond_to do |format|
        format.html { redirect_to new_user_session_path }
        format.json { head :no_content }
      end
    end
  end
end
