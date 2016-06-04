class SearchController < ApplicationController
	before_filter :if_not_signed_in

	def index
		@page_title = "Search for Allies"
		email = params[:search][:email]

		@matching_users = User

		if !email.nil?
			email.strip!
			@matching_users = @matching_users.where(email: email)
		end
		@matching_users = @matching_users.where.not(id: current_user.id).all
	end

	def posts
		if !params[:search][:name].blank?
			if params[:search][:data_type] == 'moment'
				path = moments_path(search: params[:search][:name])
			elsif params[:search][:data_type] == 'category'
				path = categories_path(search: params[:search][:name])
			elsif params[:search][:data_type] == 'mood'
				path = moods_path(search: params[:search][:name])
			elsif params[:search][:data_type] == 'strategy'
				path = strategies_path(search: params[:search][:name])
			elsif params[:search][:data_type] == 'medication'
				path = medications_path(search: params[:search][:name])
			end
		else
			if params[:search][:data_type] == 'moment'
				path = moments_path
			elsif params[:search][:data_type] == 'category'
				path = categories_path
			elsif params[:search][:data_type] == 'mood'
				path = moods_path
			elsif params[:search][:data_type] == 'strategy'
				path = strategies_path
			elsif params[:search][:data_type] == 'medication'
				path = medications_path
			end
		end

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
