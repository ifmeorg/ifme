# frozen_string_literal: true

module GroupNotificationHelper
  def group_leader_notify(data, recipient, type)
    if type == 'add_group_leader'
      add_group_notify(data, recipient)
    elsif type == 'remove_group_leader'
      remove_group_notify(data, recipient)
    end
  end

  def new_group_notify(data)
    case data['type']
    when 'new_group'
      @subject = new_group_subject(data)
      @message = new_group_body(data)
    when 'new_group_member'
      @subject = new_group_member_subject(data)
      @message = add_remove_group_leader_body(data)
    else
      @message = nil
    end
  end

  def add_group_notify(data, recipient)
    @message = add_remove_group_leader_body(data)
    @subject = if you?(recipient, data)
                 add_group_leader_you_subject(data)
               else
                 add_group_leader_subject(data)
               end
  end

  def remove_group_notify(data, recipient)
    @message = add_remove_group_leader_body(data)
    @subject = if you?(recipient, data)
                 remove_group_leader_you_subject(data)
               else
                 remove_group_leader_subject(data)
               end
  end

  def new_meeting_group_notify(data)
    @subject = new_meeting_subject(data)
    @message = meeting_body(data) + new_meeting_link(data)
  end

  def update_meeting_group_notify(data)
    @subject = update_meeting_subject(data)
    @message = meeting_body(data) + update_meeting_link(data)
  end

  def remove_meeting_group_notify(data)
    @subject = remove_meeting_subject(data)
    @message = add_remove_group_leader_body(data)
  end

  def join_meeting_group_notify(data)
    @subject = join_meeting_subject(data)
    @message = join_meeting_body(data)
  end
end
