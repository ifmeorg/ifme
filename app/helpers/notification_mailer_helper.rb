module NotificationMailerHelper
  def comment_on_moment_subject(data)
    I18n.t(
      val('comment_on_moment_subject'),
      user: data['user'].to_s,
      moment: data['moment'].to_s
    )
  end

  def comment_on_strategy_subject(data)
    I18n.t(
      val('comment_on_strategy_subject'),
      user: data['user'].to_s,
      strategy: data['strategy'].to_s
    )
  end

  def comment_on_meeting_subject(data)
    groupid = Meeting.where(id: data['meetingid']).first.groupid
    group = Group.where(id: groupid).first.name
    I18n.t(
      val('comment_on_meeting_subject'),
      user: data['user'].to_s,
      meeting: data['meeting'].to_s,
      group: group.to_s
    )
  end

  def comment_body(data, key)
    I18n.t(key, user: data['user'].to_s)
  end

  def comment_text(data, key)
    I18n.t(key, comment: data['comment'].to_s)
  end

  def comment_link(link)
    I18n.t(val('comment_link'), link: link)
  end

  def new_group_subject(data)
    user_group(data, 'new_group_subject')
  end

  def new_group_body(data)
    link_name = I18n.t('click_here')
    I18n.t(
      val('new_group_body'),
      subject: new_group_subject(data),
      description: Group.where(id: data['groupid']).first.description,
      link: link_to(link_name, group_url(data['groupid']))
    )
  end

  def new_group_member_subject(data)
    I18n.t(
      val('new_group_member_subject'),
      user: data['user'].to_s,
      group: data['group'].to_s
    )
  end

  def add_group_leader_you_subject(data)
    group(data, 'add_group_leader_you_subject')
  end

  def add_group_leader_subject(data)
    user_group(data, 'add_group_leader_subject')
  end

  def add_remove_group_leader_body(data)
    link_name = I18n.t('click_here')
    link = link_to(link_name, group_url(data['groupid']))
    I18n.t(val('add_group_leader_body'), group: data['group'].to_s, link: link)
  end

  def remove_group_leader_you_subject(data)
    group(data, 'remove_group_leader_you_subject')
  end

  def remove_group_leader_subject(data)
    group(data, 'add_group_leader_subject')
  end

  def update_meeting_subject(data)
    user_meeting_group(data, 'update_meeting_subject')
  end

  def new_meeting_subject(data)
    user_meeting_group(data, 'new_meeting_subject')
  end

  def meeting_body(data)
    meeting = Meeting.where(id: data['meetingid']).first
    I18n.t(
      val('meeting_body'),
      subject: new_meeting_subject(data),
      description: meeting.description,
      location: meeting.location,
      date: meeting.date,
      time: meeting.time
    )
  end

  def new_meeting_link(data)
    link_name = I18n.t('click_here')
    link = link_to(link_name, meeting_url(data['meetingid']))
    I18n.t(val('new_meeting_link'), link: link)
  end

  def update_meeting_link(data)
    link_name = I18n.t('click_here')
    link = link_to(link_name, meeting_url(data['meetingid']))
    I18n.t(val('update_meeting_link'), link: link)
  end

  def remove_meeting_subject(data)
    user_meeting_group(data, 'remove_meeting_subject')
  end

  def join_meeting_subject(data)
    user_meeting_group(data, 'join_meeting_subject')
  end

  def join_meeting_body(data)
    link_name = I18n.t('click_here')
    link = link_to(link_name, meeting_url(data['meetingid']))
    I18n.t(val('join_meeting_body'), meeting: data['meeting'].to_s, link: link)
  end

  def val(key)
    "notifications.mailer.#{key}"
  end

  private

  def user_meeting_group(data, key)
    I18n.t(
      val(key),
      user: data['user'].to_s,
      meeting: data['meeting'].to_s,
      group: data['group'].to_s
    )
  end

  def group(data, key)
    I18n.t(val(key), group: data['group'].to_s)
  end

  def user_group(data, key)
    I18n.t(val(key), user: data['user'].to_s, group: data['group'].to_s)
  end
end
