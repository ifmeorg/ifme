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
        invited = resource.errors.empty?
        (invited ? successful_invites : failed_invites) << invitee
      end
      invitation_flash_messages(successful_invites, failed_invites)
      redirect_to new_user_invitation_path
    end

    private

    def invitation_flash_messages(invites, fails)
      return unless is_flashing_format?

      flash_message(invites, true) unless invites.empty?
      flash_message(fails, false) unless fails.empty?
    end

    def flash_message(emails, has_invites)
      status = has_invites ? :notice : :alert
      message = has_invites ? :send_instructions : :failed_send
      set_flash_message status, message, email: emails.join(', ')
    end
  end
end
