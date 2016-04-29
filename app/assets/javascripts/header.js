$(document).on("page:load ready", function() {
  var the_height = $('#header').height();
  $('#header_space').css({"height": the_height});

  var click_flag = 0;

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

  $(window).resize(function () {
    var the_height = $('#header').height();
    $('#header_space').css({"height": the_height});
  });
});

