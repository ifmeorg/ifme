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

      flash_message(invites, true)
      flash_message(fails, false)
    end

    def flash_message(emails, has_invites)
      return unless emails.any?

      set_flash_message(
        get_status(has_invites),
        get_message(has_invites),
        email: emails.join(', ')
      )
    end

    def get_status(has_invites)
      has_invites ? :notice : :alert
    end

    def get_message(has_invites)
      has_invites ? :send_instructions : :failed_send
    end
  end
end
