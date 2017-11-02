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
      redirect_to new_user_invitatigion_path
    end

    private

    def invitation_flash_messages(invites, fails)
      return unless is_flashing_format?
      invites_flash(invites) unless invites.empty?
      fails_flash(fails) unless fails.empty?
    end

    def invites_flash(invites)
      set_flash_message :notice, :send_instructions, email: invites.join(', ')
    end

    def fails_flash(fails)
      set_flash_message :alert, :failed_send, email: fails.join(', ')
    end
  end
end
