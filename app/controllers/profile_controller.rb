class ProfileController < ApplicationController
	before_filter :if_not_signed_in

	def index
		@profile = User.where(:id => params[:userid]).first
		@triggers = Trigger.where(:userid => @profile.id)
		if @profile.blank?
			@profile = current_user
		end
		@page_title = @profile.firstname + " " + @profile.lastname
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
