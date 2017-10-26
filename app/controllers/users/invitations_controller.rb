# frozen_string_literal: true

module Users
  class InvitationsController < Devise::InvitationsController
    # POST /resource/invitation

    def create
      successful_invites = []
      failed_invites = []
      invitees = params[:user][:email].split(/,\s*/)
      invitees.each do |invitee|
        resource = User.invite!({ email: invitee }, current_user)
        resource_invited = resource.errors.empty?
        if resource_invited
          successful_invites << invitee
        else
          failed_invites << invitee
        end
      end

      if is_flashing_format? && !successful_invites.empty?
        set_flash_message :notice, :send_instructions, email: successful_invites.join(', ')
      end
      if failed_invites
        set_flash_message :alert, :failed_send, email: failed_invites.join(', ')
      end
      redirect_to new_user_invitation_path
    end
  end
end
