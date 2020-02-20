# frozen_string_literal: true
class CustomDeviseMailer < Devise::Mailer
  before_action :load_logo_inline

  protected

  def load_logo_inline
    attachments.inline['logo@2x.png'] = File.read('./public/logo@2x.png')
  end

  def subject_for(key)
    return super unless key.to_s == 'invitation_instructions'

    if @resource.invited_by&.name
      I18n.t(
        'devise.mailer.invitation_instructions.subject',
        name: @resource.invited_by&.name
      )
    else
      I18n.t('devise.mailer.invitation_instructions.subject_nameless')
    end
  end
end
