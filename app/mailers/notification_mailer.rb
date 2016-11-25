class NotificationMailer < ApplicationMailer
  default from: ENV['SMTP_ADDRESS']

  ALLY_NOTIFY_TYPES = %w(new_ally_request accepted_ally_request).freeze

  def take_medication(reminder)
    @medication = reminder.medication
    @user = @medication.user
    mail(to: @user.email,
         subject: "Don't forget to take #{@medication.name}!")
  end

  def refill_medication(reminder)
    @medication = reminder.medication
    @user = @medication.user
    mail(to: @user.email,
         subject: "Your refill for #{@medication.name} is coming up soon!")
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
    @data = HashWithIndifferentAccess.new(JSON.parse(data))
    @recipient = User.where(id: recipientid).first
    subject = 'if me | '

    if (can_notify(@recipient, 'comment_notify') &&
        (@data['type'] == 'comment_on_moment' ||
         @data['type'] == 'comment_on_moment_private' ||
         @data['type'] == 'comment_on_strategy' ||
         @data['type'] == 'comment_on_strategy_private' ||
         @data['type'] == 'comment_on_meeting'))

      if (@data['type'] == 'comment_on_moment' || @data['type'] == 'comment_on_moment_private')
        subject += @data['user'].to_s + ' commented on your moment "' + @data['moment'].to_s + '"'
      elsif @data['type'] == 'comment_on_strategy' || @data['type'] == 'comment_on_strategy_private'
        subject += @data['user'].to_s + ' commented on your strategy "' + @data['strategy'].to_s + '"'
      else
        groupid = Meeting.where(id: @data['meetingid']).first.groupid
        group = Group.where(id: groupid).first.name
        subject += @data['user'].to_s + ' commented on the meeting "' + @data['meeting'].to_s + '" in the group "' + group.to_s + '"'
      end

      if @data['type'] == 'comment_on_moment_private' || @data['type'] == 'comment_on_strategy_private'
        @message = '<p>Your ally <strong>' + @data['user'].to_s + '</strong> commented privately:</p>';
      else
        @message = '<p>Your ally <strong>' + @data['user'].to_s + '</strong> commented:</p>';
      end

      if @data['cutoff']
        @message += '<p><i>' + @data['comment'].to_s + ' [...]</i></p>'
      else
        @message += '<p><i>' + @data['comment'].to_s + '</i></p>'
      end

      if (@data['type'] == 'comment_on_moment' || @data['type'] == 'comment_on_moment_private')
        link = link_to("here", moment_url(@data['momentid']))
        @message += '<p>You can read it all ' + link + '!</p>'
      elsif @data['type'] == 'comment_on_strategy' || @data['type'] == 'comment_on_strategy_private'
        link = link_to("here", strategy_url(@data['strategyid']))
        @message += '<p>You can read it all ' + link + '!</p>'
      else
        link = link_to("here", meeting_url(@data['meetingid']))
        @message += '<p>You can read it all ' + link + '!</p>'
      end

      mail(to: @recipient.email, subject: subject)
    elsif (can_notify(@recipient, 'ally_notify') && ALLY_NOTIFY_TYPES.include?(@data['type']))
      notification = create_notifier
      @message = notification.message
      mail(to: notification.to, subject: notification.subject)
    elsif ((can_notify(@recipient, 'group_notify') &&
            (@data['type'] == 'new_group' ||
             @data['type'] == 'new_group_member' ||
             @data['type'] == 'add_group_leader' ||
             @data['type'] == 'remove_group_leader')) ||
      (can_notify(@recipient, 'meeting_notify') &&
       (@data['type'] == 'new_meeting' ||
        @data['type'] == 'remove_meeting' ||
        @data['type'] == 'update_meeting' ||
        @data['type'] == 'join_meeting')))

      if @data['type'] == 'new_group'
        what = @data['user'].to_s + ' created a group "' + @data['group'].to_s + '"'
        subject += what
        group_description = Group.where(id: @data['groupid']).first.description
        link = link_to("click here", group_url(@data['groupid']))
        @message = '<p>' + what + ':</p>'
        @message += '<p><i>' + group_description.to_s + '</i></p>'
        @message += '<p>To learn more and join, ' + link + '!</p>'

      elsif @data['type'] == 'new_group_member'
        subject += @data['user'].to_s + ' joined your group "' + @data['group'].to_s + '"'
        link = link_to("click here", group_url(@data['groupid']))
        @message = '<p>To see ' + @data['group'].to_s + ', ' + link + '!</p>'

      elsif @data['type'] == 'add_group_leader'
        if @recipient.name == @data['user']
          subject += 'You became a leader of "' + @data['group'].to_s + '"'
        else
          subject += @data['user'].to_s + ' became a leader of "' + @data['group'].to_s + '"'
        end
        link = link_to("click here", group_url(@data['groupid']))
        @message = '<p>To see ' + @data['group'].to_s + ', ' + link + '! </p>'

      elsif @data['type'] == 'remove_group_leader'
        if @recipient.name == @data['user']
          subject += 'You are no longer a leader of "' + @data['group'].to_s + '"'
        else
          subject += @data['user'].to_s + ' is no longer a leader of "' + @data['group'].to_s + '"'
        end
        link = link_to("click here", group_url(@data['groupid']))
        @message = '<p>To see ' + @data['group'].to_s + ', ' + link + '!</p>'

      elsif @data['type'] == 'new_meeting' || @data['type'] == 'update_meeting'
        if @data['type'] == 'update_meeting'
          what = @data['user'].to_s + ' has updated the meeting "' + @data['meeting'].to_s + '" for "' + @data['group'].to_s + '"'
        else
          what = @data['user'].to_s + ' created a new meeting "' + @data['meeting'].to_s + '" for "' + @data['group'].to_s + '"'
        end
        subject += what

        meeting_description = Meeting.where(id: @data['meetingid']).first.description
        meeting_location = Meeting.where(id: @data['meetingid']).first.location
        meeting_date = Meeting.where(id: @data['meetingid']).first.date
        meeting_time = Meeting.where(id: @data['meetingid']).first.time
        link = link_to("click here", meeting_url(@data['meetingid']))
        @message = '<p>' + what + ':</p>'
        @message += '<p><i>' + meeting_description.to_s + '</i></p>'
        @message += '<p><strong>Location:</strong> ' + meeting_location.to_s + '</p>'
        @message += '<p><strong>Date:</strong> ' + meeting_date.to_s + '</p>'
        @message += '<p><strong>Time:</strong> ' + meeting_time.to_s + '</p>'

        if @data['type'] == 'new_meeting'
          @message += '<p>To learn more and attend, ' + link + '!</p>'
        else
          @message += '<p>To learn more, ' + link + '!</p>'
        end

      elsif @data['type'] == 'remove_meeting'
        subject += @data['user'].to_s + ' has cancelled "' + @data['meeting'].to_s + '" for "' + @data['group'].to_s + '"'
        link = link_to("click here", group_url(@data['groupid']))
        @message = '<p>To see ' + @data['group'].to_s + ', ' + link + '!</p>'

      elsif @data['type'] == 'join_meeting'
        subject += @data['user'].to_s + ' has joined "' + @data['meeting'].to_s + '" for "' + @data['group'].to_s + '"'
        link = link_to("click here", meeting_url(@data['meetingid']))
        @message = '<p>To see ' + @data['meeting'].to_s + ', ' + link + '!</p>'

      end

      mail(to: @recipient.email, subject: subject)
    end
  end

  private

  def notification_dictionary
    {
      'new_ally_request'      => AllyNotifications::NewAllyRequest,
      'accepted_ally_request' => AllyNotifications::AcceptedAllyRequest
    }
  end

  def create_notifier
    notification_dictionary[@data[:type]].new(@recipient, @data)
  end
end
