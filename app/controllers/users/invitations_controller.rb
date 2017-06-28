class Users::InvitationsController < Devise::InvitationsController
  # POST /resource/invitation
  def create
    self.resource = invite_resource
    resource_invited = resource.errors.empty?

    yield resource if block_given?

    if resource_invited
      if is_flashing_format? && self.resource.invitation_sent_at
        set_flash_message :notice, :send_instructions, email: self.resource.email
      end
      respond_with resource, location: new_user_invitation_path
    else
      respond_with_navigational(resource) { render :new }
    end
  end
end
