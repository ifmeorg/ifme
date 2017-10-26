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
        (resource.errors.empty? ? successful_invites : failed_invites) << invitee
      end
      invitation_flash_messages(successful_invites, failed_invites)
      redirect_to new_user_invitation_path
    end

    private

    def invitation_flash_messages(invites, failures)
      if invites && is_flashing_format?
        set_flash_message :notice, :send_instructions, email: invites.join(', ')
      end
      if failures
        set_flash_message :alert, :failed_send, email: failures.join(', ')
      end
    end
  end
end
