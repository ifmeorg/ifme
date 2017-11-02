# frozen_string_literal: true

include InvitationsHelper
# inviter_name method from InvitationsHelper

class CustomDeviseMailer < Devise::Mailer
  protected

  def subject_for(key)
    return super unless key.to_s == 'invitation_instructions'

    I18n.t(
      'devise.mailer.invitation_instructions.subject',
      name: inviter_name(@resource)
    )
  end
end
