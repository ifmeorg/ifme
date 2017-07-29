# frozen_string_literal: true

class ApplicationMailer < ActionMailer::Base
  include ActionView::Helpers::UrlHelper
  include ApplicationMailerHelper
  include NotificationMailerHelper
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
    @data = data
    @recipient = recipient

    if comment_on_moment(@data) || comment_on_moment_private(@data)
      subject = comment_on_moment_subject(@data)
    elsif comment_on_strategy(@data) || comment_on_strategy_private(@data)
      subject = comment_on_strategy_subject(@data)
    else
      subject = comment_on_meeting_subject(@data)
    end

    pri = comment_on_moment_private(@data) || comment_on_strategy_private(@data)
    key = pri ? val('comment_on_private_body') : val('comment_on_body')
    @message = comment_body(@data, key)
    key = @data['cutoff'] ? val('comment_text_cutoff') : val('comment_text')
    @message += comment_text(@data, key)

    if comment_on_moment(@data) || comment_on_moment_private(@data)
      link = link_to(I18n.t('click_here'), moment_url(@data['momentid']))
    elsif comment_on_strategy(@data) || comment_on_strategy_private(@data)
      link = link_to(I18n.t('click_here'), strategy_url(@data['strategyid']))
    else
      link = link_to(I18n.t('click_here'), meeting_url(@data['meetingid']))
    end
    @message += comment_link(link)

    mail(to: @recipient.email, subject: subject)
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
    @data = data
    @recipient = recipient

    if @data['type'] == 'new_group'
      subject = new_group_subject(@data)
      @message = new_group_body(@data)
    elsif @data['type'] == 'new_group_member'
      subject = new_group_member_subject(@data)
      @message = add_remove_group_leader_body(@data)
    elsif @data['type'] == 'add_group_leader' && you?(@recipient, @data)
      subject = add_group_leader_you_subject(@data)
      @message = add_remove_group_leader_body(@data)
    elsif @data['type'] == 'add_group_leader'
      subject = add_group_leader_subject(@data)
      @message = add_remove_group_leader_body(@data)
    elsif @data['type'] == 'remove_group_leader' && you?(@recipient, @data)
      subject = remove_group_leader_you_subject(@data)
      @message = add_remove_group_leader_body(@data)
    elsif @data['type'] == 'remove_group_leader'
      subject = remove_group_leader_subject(@data)
      @message = add_remove_group_leader_body(@data)
    elsif @data['type'] == 'new_meeting'
      subject = new_meeting_subject(@data)
      @message = meeting_body(@data) + new_meeting_link(@data)
    elsif @data['type'] == 'update_meeting'
      subject = update_meeting_subject(@data)
      @message = meeting_body(@data) + update_meeting_link(@data)
    elsif @data['type'] == 'remove_meeting'
      subject = remove_meeting_subject(@data)
      @message = add_remove_group_leader_body(@data)
    elsif @data['type'] == 'join_meeting'
      subject = join_meeting_subject(@data)
      @message = join_meeting_body(@data)
    end
    mail(to: @recipient.email, subject: subject)
  end
end
