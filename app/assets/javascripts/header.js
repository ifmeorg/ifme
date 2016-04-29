$(document).on("page:load ready", function() {
  var the_height = $('#header').height();
  $('#header_space').css({"height": the_height});

  var click_flag = 0;
  var click_flag2 = 0;

  $('.expand_button').click(function(event) {
    event.preventDefault();
    if (click_flag % 2 == 0) {
      $('#expand_me').css({"display": "block"});
      $('#me').css({"opacity": 0.8});
      $('#title_expand').css({"opacity": 0.8});
    } else {
      $('#expand_me').css({"display": "none"});
      $('#me').css({"opacity": 1});
      $('#title_expand').css({"opacity": 1});
    }

    the_height = $('#header').height();
    $('#header_space').css({"height": the_height});
    click_flag++;
  });

  $('.expand_trigger_button').mouseover(function() {
    if ($('#expand_trigger').css('display') == "none") {
      $('#expand_trigger').css({"display": "block"});

      if ($('#expand_me').css('display') == "block") click_flag++;
      $('#expand_me').css({"display": "none"});
      $('#me').css({"opacity": 1});
      $('#title_expand').css({"opacity": 1});

      the_height = $('#header').height();
      $('#header_space').css({"height": the_height});
    }
  });

  $(':not(.expand_trigger_button)').click(function() {
    $('#expand_trigger').css({"display": "none"});
    $('#trigger').css({"opacity": 1});
    $('#title_expand').css({"opacity": 1});
    the_height = $('#header').height();
    $('#header_space').css({"height": the_height});
  });

  $('#notifications_button').css({"opacity": 1});
  $('#notifications_button').click(function() {
    event.preventDefault();
    if (click_flag2 % 2 == 0) {
      $('#notifications').css({"display": "block"});
      $('#notifications_button').css({"opacity": 0.5});

      if (typeof(Storage) !== "undefined" && $('#notifications_list').is(':empty')) {
        $('#notifications_list').append(localStorage.getItem("notifications_list"));
      }

      if ($('#notifications_list').is(':empty')) {
        $('#notifications_none').css({"display": "block"});
      } else {
        $('#notifications_none').css({"display": "none"});
      }
    } else {
      $('#notifications').css({"display": "none"});
      $('#notifications_button').css({"opacity": 1});
    }
    click_flag2++;
  });

  $('#close_notifications').click(function() {
    event.preventDefault();
    $('#notifications').css({"display": "none"});
    $('#notifications_button').css({"opacity": 1});
    click_flag2++;

    if (window.location.pathname.indexOf('allies') > -1 || 
      window.location.pathname.indexOf('profile') > -1 || 
      window.location.pathname.indexOf('allies') > -1) {
      location.reload();
    }
  });

   $('#clear_notifcations').click(function() {
    $('#notifications_list').empty();
    $('#notifications_none').css({"display": "block"});
    localStorage.removeItem("notifications_list");
  });

  $(window).resize(function () {
    var the_height = $('#header').height();
    $('#header_space').css({"height": the_height});
  });
});
