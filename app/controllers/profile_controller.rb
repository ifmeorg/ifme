class ProfileController < ApplicationController
	before_filter :if_not_signed_in

	def index
		# If the specified profile doesn't exist, view the current user's profile
		user = User.find_by(uid: params[:uid])
		user = current_user if user.nil?

		# Determine how the profile should be displayed based on the userid
		if user == current_user
			@moments = Moment.where(userid: current_user.id).all.order("created_at DESC")
		elsif current_user.allies_by_status(:accepted).include? user
			@moments = Moment.where(userid: user).all.order("created_at DESC")
		end

		@profile = user
		@page_title = user.name
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
