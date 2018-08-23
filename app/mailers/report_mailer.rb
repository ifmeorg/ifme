class ReportMailer < ApplicationMailer
    default from: ENV['SMTP_ADDRESS']

  def report_email(recipient,email_id)
    mail(to: email_id, subject: 'You have reported a user!')
  end
end
