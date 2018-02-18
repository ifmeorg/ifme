# frozen_string_literal: true

class RegistrationsController < Devise::RegistrationsController
  def after_update_path_for(_resource)
    edit_user_registration_path
  end

  def update_resource(resource, params)
    if current_user.provider == 'google_oauth2' || current_user.provider == 'facebook'
      params.delete('current_password')
      resource.update_without_password(params)
    else
      resource.update_with_password(params)
    end
  end
end
