var NotificationRenderer = function(notification) {
  this.notification = notification;
}

NotificationRenderer.prototype.render = function() {
  var uniqueid = this.notification.uniqueid;
  var data = JSON.parse(this.notification.data);

  if (data.type.includes('comment')) {
    return commentNotificationLink(uniqueid, data);
  } else if (data.type === 'accepted_ally_request') {
    return acceptedAllyNotificationLink(uniqueid, data);
  } else if (data.type === 'new_ally_request') {
    return newAllyRequestNotificationLink(uniqueid, data);
  } else if (data.type.includes('group')) {
    return groupNotificationLink(uniqueid, data);
  } else if (data.type.includes('meeting')) {
    return meetingNotificationLink(uniqueid, data);
  }
}

function momentComment(data) {
  return {
    path: '/moments/' + data.typeid,
    commentable_id: data.commentable_id
  }
}

function strategyComment(data) {
  return {
    path: '/strategies/' + data.typeid,
    commentable_id: data.commentable_id
  }
}

function meetingComment(data) {
  return {
    path: '/meetings/' + data.typeid,
    commentable_id: data.commentable_id
  }
}

function commentForType(data) {
  if (data.type.includes('moment')) {
    return momentComment(data);
  } else if (data.type.includes('strategy')) {
    return strategyComment(data);
  } else if (data.type.includes('meeting')) {
    return meetingComment(data);
  }
}

function commentNotificationLink(uniqueid, data) {
  var comment = commentForType(data);
  var i18nKey = data.cutoff ? 'truncated' : 'full';

  var notification = I18n.t('notifications.comment.' + i18nKey,
                            { name: data.user,
                              comment: data.comment,
                              typename: data.typename });

  return notificationLink(uniqueid, comment.path, notification);
}

function meetingNotificationLink(uniqueid, data) {
  var notification = I18n.t('notifications.meeting.' + data.type,
                     { name: data.user, group_name: data.group, meeting_name: data.typename });

  var link = data.type.includes('remove') ?
             '/groups/' + data.group_id :
             '/meetings/' + data.typeid;

  return notificationLink(uniqueid, link, notification);
}

function groupNotificationLink(uniqueid, data) {
  var notification = I18n.t('notifications.group.' + data.type,
                        { name: data.user, group_name: data.group });

  var link = '/groups/' + data.group_id;

  return notificationLink(uniqueid, link, notification);
}

function acceptedAllyNotificationLink(uniqueid, data) {
  var notification = I18n.t('notifications.ally.accepted', { name: data.user });
  var link = '/profile?uid=' + data.uid;
  return notificationLink(uniqueid, link, notification);
}

function newAllyRequestNotificationLink(uniqueid, data) {
  var link = '/profile?uid=' + data.uid;
  var linkHtml = '<a class="notification_link display_inline" href="' + link + '">' +
                   data.user +
                 '</a>';

  return '<div id="' + uniqueid + '" class="small_margin_top">' +
            I18n.t('notifications.ally.sent_html', { link_to_user: linkHtml }) +
            acceptRejectIcons(data.user_id) +
          '</div>';
}

function notificationLink(uniqueid, link, notification) {
  return '<a class="notification_link" id="' + uniqueid + '" href="' + link + '">' +
           notification +
         '</a>';
}

function acceptRejectIcons(user_id) {
  var add = '/allies/add?ally_id=' + user_id + '&refresh=' + window.location.pathname;
  var remove = '/allies/remove?ally_id=' + user_id + '&refresh=' + window.location.pathname;

  var accept = '<a rel="nofollow" data-method="post" class="notification_link small_margin_left display_inline" href="' + add + '"><i class="fa fa-check"></i></a>';
  var reject = '<a data-confirm="' + I18n.t('common.actions.confirm') + '" rel="nofollow" data-method="post" class="notification_link small_margin_left display_inline" href="' + remove + '"><i class="fa fa-times"></i></a>';

  return accept + reject;
}

// polyfill for string.includes
// https://developer.mozilla.org/en-US/docs/Web/JavaScript/Reference/Global_Objects/String/includes

/* eslint-disable */
if (!String.prototype.includes) {
  String.prototype.includes = function(search, start) {
    'use strict';
    if (typeof start !== 'number') {
      start = 0;
    }

    if (start + search.length > this.length) {
      return false;
    } else {
      return this.indexOf(search, start) !== -1;
    }
  };
}
/* eslint-enable */
