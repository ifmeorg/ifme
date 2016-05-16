$(document).on("page:load ready", function() {
  /* Pusher */
  var pusher;

  $.ajax({
    dataType: "json",
    url: "/notifications/signed_in",
    type: "GET",
    success: function(json) {
      if (json !== undefined) {
        var result = json.signed_in;

        if (result != -1) {
          // Show notifications on initial sign in
          if ($('body').hasClass('pages home')) {
            fetchNotifications();
          }

          pusher = new Pusher('[insert Pusher.key from pusher.rb here]', {
            encrypted: true
          });

          var channel = pusher.subscribe('private-' + result);
          channel.bind('new_notification', function(data) {
            renderNotifications(data.notifications);
          });
        }
      }
    }
  });

  var click_flag = 0;

  resetNotificationsButton();
  $('.notifications_button').click(function(event) {
    event.preventDefault();
    if (click_flag % 2 == 0) {
      showNotifications();
      pressNotificationsButton();

      // Fetch notifications for current_user
      fetchNotifications();
    } else {
      hideNotifications();
      resetNotificationsButton();
    }
    click_flag++;
  });

  $('#close_notifications').click(function() {
    hideNotifications();
    resetNotificationsButton();
    click_flag++;
  });

   $('#clear_notifcations').click(function() {
    emptyNotificationsList();
    showNotificationsNone();
    changeTitle(0);

    $.ajax("/notifications/clear");
  });

  /* Quick Moment */
  $('#toggle_categories_moods').click(function() {
    if ($('#categories_moods')[0].classList.contains('display_none')) {
      showCategoriesMoods();
    } else {
      hideCategoriesMoods();
    }
  }); 

  $('#close_categories_moods').click(function() {
    hideCategoriesMoods();
  });

  /* Tips */
  var tip_click_flag = 0;

  $(document).on('click', '.tip_notifications_button', function() {
    if (tip_click_flag % 2 == 0) {
      $(this).siblings('.tip_notifications').css({"display": "block"});

    } else {
      $(this).siblings('.tip_notifications').css({"display": "none"});
    }
    tip_click_flag++;
  });

  $(document).on('click', '.tip_close_notifications', function() {
    $(this).closest('.tip_notifications').css({"display": "none"});
    tip_click_flag++;
  });

  /* Quick Create */
  var category_click_flag = 0;
  var mood_click_flag = 0;
  var strategy_click_flag = 0;

  $('#category_quick_button').click(function() {
    if (category_click_flag % 2 == 0) {
      $('#category_quick_create').css({"display": "block"});

    } else {
      $('#category_quick_create').css({"display": "none"});
    }
    category_click_flag++;
  });

  $('#mood_quick_button').click(function() {
    if (mood_click_flag % 2 == 0) {
      $('#mood_quick_create').css({"display": "block"});

    } else {
      $('#mood_quick_create').css({"display": "none"});
    }
    mood_click_flag++;
  });

  $('#strategy_quick_button').click(function() {
    if (strategy_click_flag % 2 == 0) {
      $('#strategy_quick_create').css({"display": "block"});

    } else {
      $('#strategy_quick_create').css({"display": "none"});
    }
    strategy_click_flag++;
  });

  $('.quick_create_close').click(function() {
    if ($(this).closest('.quick_create').attr('id') == 'category_quick_create') {
      $('#category_quick_create').css({"display": "none"});
      category_click_flag++;
    } else if ($(this).closest('.quick_create').attr('id') == 'mood_quick_create') {
      $('#mood_quick_create').css({"display": "none"});
      mood_click_flag++;
    } else if ($(this).closest('.quick_create').attr('id') == 'strategy_quick_create') {
      $('#strategy_quick_create').css({"display": "none"});
      strategy_click_flag++;
    }
  });

  $('#new_category').submit(function() {
    if ($('body').hasClass('moments new') || $('body').hasClass('strategies new')) {
      quickCreate(this, 'category');
      return false;
    }
  });

  $('#new_mood').submit(function() {
    if ($('body').hasClass('moments new')) {
      quickCreate(this, 'mood');
      return false;
    }
  });

  $('#new_strategy').submit(function() { 
    if ($('body').hasClass('moments new')) {
      quickCreate(this, 'strategy');
      return false;
    }
  });
});

function renderNotifications(notifications) {
  changeTitle(notifications.length);
  emptyNotificationsList();
  showNotifications();
  hideNotificationsNone();

  _.each(notifications, function(notification) {
    var uniqueid = notification.uniqueid;
    var data = JSON.parse(notification.data);

    if (data.type == 'comment_on_moment' || 
      data.type == 'comment_on_strategy' ||
      data.type == 'comment_on_moment_private' || 
      data.type == 'comment_on_strategy_private' ||
      data.type == 'comment_on_meeting') {
      var type_name;
      if (data.type == 'comment_on_moment' || data.type == 'comment_on_moment_private') {
        type_name = data.moment;
      } else if (data.type == 'comment_on_strategy' || data.type == 'comment_on_strategy_private') {
        type_name = data.strategy;
      } else if (data.type == 'comment_on_meeting') {
        type_name = data.meeting;
      }

      if (data.cutoff) {
        var notification = data.user + ' commented "' + data.comment + '" [...] on ' + type_name;
      } else {
        var notification = data.user + ' commented "' + data.comment + '" on ' + type_name;
      }

      var link;
      if (data.type == 'comment_on_moment' || data.type == 'comment_on_moment_private') {
        link = '/moments/' + data.momentid;
      } else if (data.type == 'comment_on_strategy' || data.type == 'comment_on_strategy_private') {
        link = '/strategies/' + data.strategyid;
      } else if (data.type == 'comment_on_meeting') {
        link = '/meetings/' + data.meetingid;
      }

      var notification_link = '<a class="notification_link" id="' + uniqueid + '" href="' + link + '">' + notification + '</a>';

      $('#notifications_list').prepend(notification_link);
    } else if (data.type == 'accepted_ally_request' || data.type == 'new_ally_request') {
      var link = '/profile?userid=' + data.userid;
      var notification_link;

      if (data.type == 'accepted_ally_request') {
        var notification = data.user + ' accepted your ally request!';
        notification_link = '<a class="notification_link" id="' + uniqueid + '" href="' + link + '">' + notification + '</a>'
      } else if (data.type == 'new_ally_request') {
        var add = '/allies/add?ally_id=' + data.userid + '&refresh=' + window.location.pathname;
        var remove = '/allies/remove?ally_id=' + data.userid + '&refresh=' + window.location.pathname;

        var accept = '<a rel="nofollow" data-method="post" class="notification_link small_margin_left display_inline" href="' + add + '"><i class="fa fa-check"></i></a>';
        var reject = '<a data-confirm="Are you sure?" rel="nofollow" data-method="post" class="notification_link small_margin_left display_inline" href="' + remove + '"><i class="fa fa-times"></i></a>';

        notification_link = '<div id="' + uniqueid + '" class ="small_margin_top"><a class="notification_link display_inline" href="' + link + '">' + data.user + '</a> sent an ally request!' + accept + reject + '</span>';
      }

      $('#notifications_list').prepend(notification_link);
    } else if (data.type == 'new_group' ||
      data.type == 'new_group_member' ||
      data.type == 'add_group_leader' ||
      data.type == 'remove_group_leader' ||
      data.type == 'new_meeting' ||
      data.type == 'remove_meeting' ||
      data.type == 'update_meeting' || 
      data.type == 'join_meeting') {
      var notification;

      if (data.type == 'new_group') {
        notification = data.user + ' created a group "' + data.group + '"';
      } else if (data.type == 'new_group_member') {
        notification = data.user + ' joined your group "' + data.group + '"';
      } else if (data.type == 'add_group_leader') {
        notification = data.user + ' became a leader of "' + data.group + '"';
      } else if (data.type == 'remove_group_leader') {
        notification = data.user + ' is no longer a leader of "' + data.group + '"';
      } else if (data.type == 'new_meeting') {
        notification = data.user + ' created a new meeting "' + data.meeting + '" for "' + data.group + '"';
      } else if (data.type == 'remove_meeting') {
        notification = data.user + ' has cancelled "' + data.meeting + '" for "' + data.group + '"';
      } else if (data.type == 'update_meeting') {
        notification = data.user + ' has updated "' + data.meeting + '" for "' + data.group + '"';
      } else if (data.type == 'join_meeting') {
        notification = data.user + ' has joined "' + data.meeting + '" for "' + data.group + '"';
      }


      var link = '/groups/' + data.groupid;

      if (data.type == 'new_meeting' ||
        data.type == 'update_meeting' || 
        data.type == 'join_meeting') {
        link = '/meetings/' + data.meetingid;
      }

      var notification_link = '<a class="notification_link" id="' + uniqueid + '" href="' + link + '">' + notification + '</a>';

      $('#notifications_list').prepend(notification_link);
    }
  })
}

function fetchNotifications() {
  $.ajax({
    dataType: "text",
    url: "/notifications/fetch_notifications",
    type: "GET",
    success: function (json) {
      var data = JSON.parse(json).fetch_notifications;
      if (data.length > 0) {
        renderNotifications(data);
      } else {
        showNotificationsNone();
      }
    }
  });
}

function showNotifications() {
  $('#notifications').removeClass('display_none');
  $('#notifications').addClass('display_block');
}

function hideNotifications() {
  $('#notifications').removeClass('display_block');
  $('#notifications').addClass('display_none');
}

function pressNotificationsButton() {
  $('.notifications_button').css({"opacity": 0.5});
}

function resetNotificationsButton() {
  $('.notifications_button').css({"opacity": 1});
}

function emptyNotificationsList() {
  $('#notifications_list').empty();
}

function showNotificationsNone() {
  $('#notifications_none').removeClass('display_none');
  $('#notifications_none').addClass('display_block');
}

function hideNotificationsNone() {
  $('#notifications_none').removeClass('display_block');
  $('#notifications_none').addClass('display_none');
}

function showCategoriesMoods() {
  $('#categories_moods').removeClass('display_none');
  $('#categories_moods').addClass('display_block');
}

function hideCategoriesMoods() {
  $('#categories_moods').removeClass('display_block');
  $('#categories_moods').addClass('display_none');
}

function quickCreate(form, data_type) {
  var values = $(form).serialize();
  $.ajax({
      type: 'POST',
      url: $(form).attr('action'),
      data: values,
      dataType: 'json'
  }).success(function(json) {
      // Update moments/strategies form
      if (data_type == 'category') {
        $('#categories_list').append(json.checkbox);
        $('#categories_list').append(json.label);
      } else if (data_type == 'mood') {
        $('#moods_list').append(json.checkbox);
        $('#moods_list').append(json.label);
      } else if (data_type == 'strategy') {
        $('#strategies_list').append(json.checkbox);
        $('#strategies_list').append(json.label);
      }

       $('.quick_create_close').click();
  });
}

function changeTitle(count) {
  var title = document.title;
  var eliminate = title.substr(0, title.indexOf(') ')) + ')';
  title = title.replace(eliminate, '');
  var newTitle = '(' + count + ') ' + title;

  if (count == 0) {
    newTitle = title;
  }

  document.title = newTitle;
}
