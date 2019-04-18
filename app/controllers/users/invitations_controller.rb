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

    def accept_resource
      invitation_token = update_resource_params[:invitation_token]
      # rubocop:disable Rails/DynamicFindBy
      # Disabling this Rubocop check because
      # find_by_invitation_token is a custom method on Devise::Invitable
      # and not a shortcut for find_by + invitation_token
      invitee = User.find_by_invitation_token(invitation_token, true)
      # rubocop:enable Rails/DynamicFindBy
      inviter = invitee.invited_by
      AllyshipCreator.perform(ally_id: invitee.id,
                              current_user: inviter)
      resource_class.accept_invitation!(update_resource_params)
    end
  end
end
