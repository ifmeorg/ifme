class SearchController < ApplicationController
	before_filter :if_not_signed_in

	def index
		@page_title = "Search for Allies"
		# name = params[:search][:name]
		# location = params[:search][:location]
		email = params[:search][:email]

		@matching_users = User
		# if !name.nil?
		# 	@matching_users = @matching_users.where("name ilike ?", "%#{name}%")
		# end
		# if !location.nil?
		# 	@matching_users = @matching_users.where("location ilike ?", "%#{location}%")
		# end
		if !email.nil?
			email.strip!
			@matching_users = @matching_users.where(email: email)
		end
		@matching_users = @matching_users.where.not(id: current_user.id).all
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
