# frozen_string_literal: true
class CustomDeviseMailer < Devise::Mailer
  protected

  def subject_for(key)
    return super unless key.to_s == 'invitation_instructions'

    if @resource.invitee&.name
      I18n.t(
        'devise.mailer.invitation_instructions.subject',
        name: @resource.invitee&.name
      )
    else
      I18n.t('devise.mailer.invitation_instructions.subject_nameless')
    end
  end
end
