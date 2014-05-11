class SearchController < ApplicationController
	before_filter :if_not_signed_in

	def index
		@page_title = "Search for Allies"

		@name = params[:search][:name]
		@location = params[:search][:location]
		@email = params[:search][:email]
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
