class ProfileController < ApplicationController
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
end
