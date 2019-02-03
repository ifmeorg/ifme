# frozen_string_literal: true

class ApplicationMailer < ActionMailer::Base
  include ActionView::Helpers::UrlHelper
  include ApplicationMailerHelper
  include NotificationMailerHelper
  include GroupNotificationHelper
  default from: ENV['SMTP_ADDRESS']
  layout 'mailer'
  ALLY_NOTIFY_TYPES = %w[new_ally_request accepted_ally_request].freeze

  def reminder_mailer(model, subject_text)
    @model = model
    @user = @model.user
    subject = I18n.t(subject_text, name: @model.name)
    mail(to: @user.email, subject: subject)
  end

  def can_comment_notify(data, recipient)
    can_notify(recipient, 'comment_notify') && can_comment(data)
  end

  def comment_notify(data, recipient)
    subject = extract_comment_notify_subject(data)
    generate_comment_notify_message(data)
    @recipient = recipient
    mail(to: recipient.email, subject: subject)
  end

  def can_ally_notify(data, recipient)
    can_notify(recipient, 'ally_notify') &&
      ALLY_NOTIFY_TYPES.include?(data['type'])
  end

  def ally_notify(data, recipient)
    @data = data
    @recipient = recipient
    notification = create_notifier
    @message = notification.message
    mail(to: notification.to, subject: notification.subject)
  end

  def can_group_notify(data, recipient)
    (can_notify(recipient, 'group_notify') && can_group(data)) ||
      (can_notify(recipient, 'meeting_notify') && can_meeting(data))
  end

  def group_notify(data, recipient)
    @recipient = recipient
    if data['type'].start_with? 'new_group', 'new_group_member'
      new_group_notify(data)
    elsif data['type'].end_with? 'group_leader'
      group_leader_notify(data, recipient, data['type'])
    else
      meeting_notify(data, data['type'])
    end
    mail(to: recipient.email, subject: @subject) if defined?(@subject) &&
                                                    !@message.nil?
  end

  private

  def meeting_notify(data, type)
    case type
    when 'new_meeting'
      new_meeting_group_notify(data)
    when 'update_meeting'
      update_meeting_group_notify(data)
    when 'remove_meeting'
      remove_meeting_group_notify(data)
    when 'join_meeting'
      join_meeting_group_notify(data)
    end
  end

  def generate_comment_notify_message(data)
    key = extract_comment_notify_key(data)
    @message = comment_body(data, key)

    key = data['cutoff'] ? val('comment_text_cutoff') : val('comment_text')
    @message += comment_text(data, key)

    url = send("#{commented_model(data)}_url", data['typeid'])
    link = link_to(I18n.t('click_here'), url)
    @message += comment_link(link)
  end
end
