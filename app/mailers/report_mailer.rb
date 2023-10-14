# frozen_string_literal: true
class ReportMailer < ApplicationMailer
  default from: ENV.fetch('SMTP_FROM', nil)

  def reported_email(recipient, reportee)
    @recipient = recipient
    @reportee = reportee
    mail(
      to: @recipient.email,
      subject: t('notifications.mailer.reported_user_subject')
    )
  end

  def reportee_email(recipient)
    @recipient = recipient
    mail(
      to: @recipient.email,
      subject: t('notifications.mailer.reportee_user_subject')
    )
  end
end
