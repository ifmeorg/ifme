# frozen_string_literal: true
require 'cgi'

module NotificationsHelper
  def comment_link(uniqueid, data)
    comment = comment_for_type(data)
    i18n_key = data[:cutoff] ? 'truncated' : 'full'
    notification = t(
      "notifications.comment.#{i18n_key}",
      name: name_or_email(data),
      comment: strip_tags(data[:comment]),
      typename: data[:typename]
    )
    notification_link(uniqueid, comment[:path], notification)
  end

  def accepted_ally_link(uniqueid, data)
    notification = t(
      'notifications.ally.accepted',
      name: name_or_email(data)
    )
    link = "/profile?uid=#{data[:uid]}"
    notification_link(uniqueid, link, notification)
  end

  def new_ally_request_link(uniqueid, data)
    link = "/profile?uid=#{data[:uid]}"
    link_html = "<a href=\"#{link}\">#{name_or_email(data)}</a>"
    # rubocop:disable Layout/LineLength
    CGI.unescapeHTML("<div id=\"#{uniqueid}\"><div>#{t('notifications.ally.sent_html', link_to_user: link_html)}</div>#{request_actions(data[:user_id])}</div>")
    # rubocop:enable Layout/LineLength
  end

  def group_link(uniqueid, data)
    notification = t(
      "notifications.group.#{data[:type]}",
      name: name_or_email(data),
      group_name: data[:group]
    )
    link = "/groups/#{data[:group_id]}"
    notification_link(uniqueid, link, notification)
  end

  def meeting_link(uniqueid, data)
    notification = t(
      "notifications.meeting.#{data[:type]}",
      name: name_or_email(data),
      group_name: data[:group],
      meeting_name: data[:typename]
    )
    link = specific_meeting_link(data[:type], data[:typeid], data[:group_id])
    notification_link(uniqueid, link, notification)
  end

  private

  def specific_meeting_link(type, typeid, group_id)
    return "/meetings/#{typeid}" unless type.include? 'remove'

    "/groups/#{group_id}"
  end

  def request_accept(user_id)
    add = "/allies/add?ally_id=#{user_id}"
    "<a rel=\"nofollow\" data-method=\"post\" href=\"#{add}\">#{t('allies.accept')}</a>"
  end

  def request_reject(user_id)
    remove = "/allies/remove?ally_id=#{user_id}"
    # rubocop:disable Layout/LineLength
    "<a data-confirm=\"#{t('common.actions.confirm')}\" rel=\"nofollow\" data-method=\"post\" href=\"#{remove}\">#{t('allies.reject')}</a>"
    # rubocop:enable Layout/LineLength
  end

  def request_actions(user_id)
    "<div>#{request_accept(user_id)} | #{request_reject(user_id)}</div>"
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

  def name_or_email(data)
    sanitize(data[:user]).presence || data[:email]
  end
end
