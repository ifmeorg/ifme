# frozen_string_literal: true

class ReportMailer < ApplicationMailer
  default from: ENV['SMTP_ADDRESS']
  def reported_email(recipient, reportee, email_id)
    @recipient = User.find_by(id: recipient)
    @reportee = User.find_by(id: reportee)
    @email_id = email_id
    mail(to: email_id, subject: t('notifications.mailer.reported_user_subject'))
  end
  
  def reportee_email(recipient, reporter, email_id)
    @recipient = User.find_by(id: recipient)
    @reporter = User.find_by(id: reporter)
    @email_id = email_id
    mail(to: email_id, subject: t('notifications.mailer.reportee_user_subject'))
  end
end
