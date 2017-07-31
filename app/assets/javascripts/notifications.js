function showNotifications() {
  $('#notifications').removeClass('display_none');
  $('#notifications').addClass('display_block');
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

function changeTitle(count) {
  var title = document.title;
  var eliminate = title.substr(0, title.indexOf(') ')) + ')';
  title = title.replace(eliminate, '');
  var newTitle = '(' + count + ') ' + title;

  if (count === 0) {
    newTitle = title;
  }

  document.title = newTitle;
}

function renderNotifications(notifications) {
  changeTitle(notifications.length);
  emptyNotificationsList();
  showNotifications();
  hideNotificationsNone();

  _.each(notifications, function(notification) {
    var notificationLink = new NotificationRenderer(notification).render();
    $('#notifications_list').prepend(notificationLink);
  });
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
        changeTitle(data.length);
        emptyNotificationsList();
        showNotificationsNone();
      }
    }
  });
}

function hideTipNotifications() {
  $(this).closest('.tip_notifications').toggleClass("display_none");
  hideBackdrop();
}

var onReadyNotifications = function() {
  /* Pusher */
  var pusher;

  $.ajax({
    dataType: "json",
    url: "/notifications/signed_in",
    type: "GET",
    success: function(json) {
      if (json !== undefined) {
        var result = json.signed_in;

        if (result !== -1) {
          // Show notifications on initial sign in
          if ($('body').hasClass('pages home')) {
            fetchNotifications();
          }

          var pusherKey = $('meta[name="pusher-key"]').attr('content');
          pusher = new Pusher(pusherKey, {
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

  $('.notifications_button').click(function(event) {
    event.preventDefault();
    $('#notifications').addClass('display_block');
    $('#notifications').removeClass('display_none');
    $('.notifications_button').addClass('fade');
    showBackdrop();
    fetchNotifications();
  });

  $('#close_notifications').click(function() {
    $('#notifications').removeClass('display_block');
    $('#notifications').addClass('display_none');
    $('.notifications_button').removeClass('fade');
    hideBackdrop();
  });

   $('#clear_notifications').click(function() {
    emptyNotificationsList();
    showNotificationsNone();
    changeTitle(0);

    $.ajax({
      url: '/notifications/clear',
      type: 'DELETE'
    });

    $('#notifications #clear_notifications').hide();
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

  $('#categories_moods').click(function() {
    hideCategoriesMoods();
  });

  $('#categories_moods_text').click(function(event) {
    event.stopPropagation();
  });

  /* Tips */
  $('.tip_notifications_button').click(function() {
    $(this).siblings('.tip_notifications').toggleClass("display_none");
    showBackdrop();
  });

  $('.tip_close_notifications').click(function() {
    hideTipNotifications.call(this);
  });

  $('.tip_notifications').click(function() {
    hideTipNotifications.call(this);
  });

  $('.tip_notifications_text').click(function(event) {
    event.stopPropagation();
  });

  /* Handle Esc Key */
  $(document).keyup(function(event) {
    if (event.keyCode === 27) {
      if (!$('#categories_moods').hasClass('display_none')) {
        hideCategoriesMoods();
      }
      closeQuickCreate.call($('.quick_create:not(.display_none)'));
      hideTipNotifications.call($('.tip_notifications:not(.display_none)'));
    }
  });
};

$(document).on("page:load ready", onReadyNotifications);
