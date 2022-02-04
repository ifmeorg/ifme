# frozen_string_literal: true
module PageRedirectConcern
  extend ActiveSupport::Concern

  included do
    helper_method :if_not_signed_in, :if_not_admin, :redirect_to_path
  end

  def if_not_signed_in
    return if user_signed_in?

    redirect_to_path(new_user_session_path)
  end

  def if_not_admin
    return redirect_to_path(new_user_session_path) unless user_signed_in?

    return if current_user.admin?

    redirect_to_path('/')
  end

  def redirect_to_path(path)
    respond_to do |format|
      format.html { redirect_to path }
      format.json { head :no_content }
    end
  end
end
