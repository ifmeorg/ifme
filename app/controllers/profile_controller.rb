class ProfileController < ApplicationController
	def index
		@profile = User.where(:id => params[:userid]).first
		if @profile.blank?
			@profile = current_user
		end
		@page_title = @profile.firstname + " " + @profile.lastname
	end 
end
