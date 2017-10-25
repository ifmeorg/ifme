# frozen_string_literal: true

module Users
  class InvitationsController < Devise::InvitationsController
    # POST /resource/invitation

    def create
      successful_invites = []
      invitees = params[:user][:email].split(/,\s*/)
      invitees.each do |invitee|
        if invitee =~ Devise.email_regexp
          resource = User.invite!({:email => invitee}, current_user)
          resource_invited = resource.errors.empty?
          successful_invites << invitee if resource_invited
        end
      end

      if is_flashing_format? && !successful_invites.empty?
        set_flash_message :notice, :send_instructions, email: successful_invites.join(', ')
      end
      redirect_to new_user_invitation_path
    end
  end
end
