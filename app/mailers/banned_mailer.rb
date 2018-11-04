# frozen_string_literal: true
class BannedMailer < ApplicationMailer
  default from: ENV['SMTP_ADDRESS']

  def add_ban_email(recipient)
    @recipient = recipient
    mail(
      to: @recipient.email,
      subject: t('notifications.mailer.add_ban_subject')
    )
  end

  def remove_ban_email(recipient)
    @recipient = recipient
    mail(
      to: @recipient.email,
      subject: t('notifications.mailer.remove_ban_subject')
    )
  end
end
