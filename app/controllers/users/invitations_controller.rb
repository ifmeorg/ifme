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

    # PUT /resource/invitation
    # rubocop:disable MethodLength
    def update
      raw_invitation_token = update_resource_params[:invitation_token]
      self.resource = accept_resource
      invitation_accepted = resource.errors.empty?

      yield resource if block_given?

      if invitation_accepted
        AllyshipCreator.perform(ally_id: resource.id,
                                current_user: resource.invited_by)
        if resource.class.allow_insecure_sign_in_after_accept
          # rubocop:disable LineLength
          flash_message = resource.active_for_authentication? ? :updated : :updated_not_active
          # rubocop:enable LineLength
          set_flash_message :notice, flash_message if is_flashing_format?
          sign_in(resource_name, resource)
          respond_with resource, location: after_accept_path_for(resource)
        else
          set_flash_message :notice, :updated_not_active if is_flashing_format?
          respond_with resource, location: new_session_path(resource_name)
        end
      else
        resource.invitation_token = raw_invitation_token
        respond_with_navigational(resource) { render :edit }
      end
    end
    # rubocop:enable MethodLength

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
