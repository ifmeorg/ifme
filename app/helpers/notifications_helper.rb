# frozen_string_literal: true

module NotificationsHelper
  def comment_link(uniqueid, data)
    comment = comment_for_type(data)
    i18n_key = data[:cutoff] ? 'truncated' : 'full'
    notification = t(
      "notifications.comment.#{i18n_key}",
      name: data[:user],
      comment: data[:comment],
      typename: data[:typename]
    )
    notification_link(uniqueid, comment[:path], notification)
  end

  def accepted_ally_link(uniqueid, data)
    notification = t(
      'notifications.ally.accepted',
      name: data[:user]
    )
    link = "/profile?uid=#{data[:uid]}"
    notification_link(uniqueid, link, notification)
  end

  def new_ally_request_link(uniqueid, data)
    link = "/profile?uid=#{data[:uid]}"
    link_html = "<a href=\"#{link}\">#{data[:user]}</a>"
    # rubocop:disable LineLength
    "<div id=\"#{uniqueid}\"><div>#{t('notifications.ally.sent_html', link_to_user: link_html)}</div>#{request_actions(data[:user_id])}</div>"
    # rubocop:enable LineLength
  end

  def group_link(uniqueid, data)
    notification = t(
      "notifications.group.#{data[:type]}",
      name: data[:user],
      group_name: data[:group]
    )
    link = "/groups/#{data[:group_id]}"
    notification_link(uniqueid, link, notification)
  end

  def meeting_link(uniqueid, data)
    notification = t(
      "notifications.meeting.#{data[:type]}",
      name: data[:user],
      group_name: data[:group],
      meeting_name: data[:typename]
    )
    # rubocop:disable LineLength
    link = data[:type].include? 'remove' ? "/groups/#{data[:group_id]}" : "/meetings/#{data[:typeid]}"
    # rubocop:enable LineLength
    notification_link(uniqueid, link, notification)
  end

  private

  def request_accept(user_id)
    add = "/allies/add?ally_id=#{user_id}"
    # rubocop:disable LineLength
    "<a rel=\"nofollow\" data-method=\"post\" href=\"#{add}\">#{t('allies.accept')}</a>"
    # rubocop:enable LineLength
  end

  def request_reject(user_id)
    remove = "/allies/remove?ally_id=#{user_id}"
    # rubocop:disable LineLength
    "<a data-confirm=\"#{t('common.actions.confirm')}\" rel=\"nofollow\" data-method=\"post\" href=\"#{remove}\">#{t('allies.reject')}</a>"
    # rubocop:enable LineLength
  end

  def request_actions(user_id)
    "<div>#{request_accept(user_id)}#{request_reject(user_id)}</div>"
  end

  def comment_object(comment_type, data)
    {
      path: "/#{comment_type.pluralize}/#{data[:typeid]}",
      commentable_id: data[:commentable_id]
    }
  end

  def comment_for_type(data)
    if data[:type].include? 'moment'
      comment_object('moment', data)
    elsif data[:type].include? 'strategy'
      comment_object('strategy', data)
    elsif data[:type].include? 'meeting'
      comment_object('meeting', data)
    end
  end

  def notification_link(uniqueid, link, notification)
    "<a id=\"#{uniqueid}\" href=\"#{link}\">#{notification}</a>"
  end
end
