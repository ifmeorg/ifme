# frozen_string_literal: true

class NotificationMailer < ApplicationMailer
  default from: Rails.application.secrets.smtp[:address]

  def take_medication(reminder)
    reminder_mailer(reminder.medication, 'medications.reminder_mailer.subject')
  end

  def refill_medication(reminder)
    reminder_mailer(reminder.medication, 'medications.refill_mailer.subject')
  end

  def perform_strategy(reminder)
    reminder_mailer(reminder.strategy, 'strategies.reminder_mailer.subject')
  end

  def meeting_reminder(meeting, member)
    @meeting = meeting
    @member = member

    subject = I18n.t(
      'meetings.reminder_mailer.subject',
      meeting_name: @meeting.name,
      time: @meeting.time
    )

    mail(to: @member.email, subject: subject)
  end

  def notification_email(recipientid, data)
    data = HashWithIndifferentAccess.new(JSON.parse(data))
    recipient = User.where(id: recipientid).first

    if can_comment_notify(data, recipient)
      comment_notify(data, recipient)
    elsif can_ally_notify(data, recipient)
      ally_notify(data, recipient)
    elsif can_group_notify(data, recipient)
      group_notify(data, recipient)
    end
  end
end
