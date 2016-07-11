class ProfileController < ApplicationController
	before_filter :if_not_signed_in

	def index
		# If the specified profile doesn't exist, view the current user's profile
		user = User.find_by(uid: params[:uid])
		user = current_user if user.nil?

		# Determine how the profile should be displayed based on the userid
		if user == current_user
			@stories = Kaminari.paginate_array(get_stories(current_user, false)).page(params[:page]).per($per_page)
		elsif current_user.allies_by_status(:accepted).include? user
			@stories = Kaminari.paginate_array(get_stories(user, false)).page(params[:page]).per($per_page)
		end

		@profile = user
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
