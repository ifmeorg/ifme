# frozen_string_literal: true
# inviter_name method from InvitationsHelper
include InvitationsHelper

class CustomDeviseMailer < Devise::Mailer
  protected

  def subject_for(key)
    return super unless key.to_s == 'invitation_instructions'

    if inviter_name(@resource)
      I18n.t(
        'devise.mailer.invitation_instructions.subject',
        name: inviter_name(@resource)
      )
    else
      I18n.t('devise.mailer.invitation_instructions.subject_nameless')
    end
  end
end
