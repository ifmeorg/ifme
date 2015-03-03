class ProfileController < ApplicationController
	before_filter :if_not_signed_in

	def index
		# If the specified profile doesn't exist, view the current user's profile
		params[:userid] = params[:userid].to_i
		params[:userid] = current_user.id if params[:userid].nil? || !User.where(id: params[:userid]).exists?

		# Determine how the profile should be displayed based on the userid
		@type = user_relation(current_user.id, params[:userid])
		if @type == UserRelation::MYSELF
			@triggers = Trigger.where(userid: current_user.id).all
		elsif @type == UserRelation::ALLY
			@triggers = Trigger.where(userid: params[:userid]).all
		end

		@profile = User.where(:id => params[:userid]).first
		@page_title = @profile.name
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
