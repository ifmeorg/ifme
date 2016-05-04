$(document).on("page:load ready", function() {
  setHeight();

  var click_flag = 0;

  $('.expand_button').click(function(event) {
    event.preventDefault();
    hideSmallTopNav();

    if (click_flag % 2 == 0) {
      showExpandMe();
    } else {
      hideExpandMe();
    }

    setHeight();
    click_flag++;
  });

  $('#expand_nav').click(function() {
    hideExpandMe();

    if ($('#small_nav')[0].classList.contains('display_none')) {
      showSmallTopNav();
    } else {
      hideSmallTopNav();
    }
  });

  $('.expand_moment_button').mouseover(function() {
    if ($('#expand_moment')[0].classList.contains('display_none')) {
      showExpandMoment();

      if ($('#expand_me')[0].classList.contains('display_block')) {
        click_flag++;
      }

      hideExpandMe();
      setHeight();
    }
  });

  $(':not(.expand_moment_button)').click(function() {
    hideExpandMoment();
    setHeight();
  });

  $(window).resize(function () {
    setHeight();
  });
});

function hideSmallTopNav() {
  $('#small_nav').removeClass('display_block');
  $('#small_nav').addClass('display_none');
  $('#expand_nav').css({"opacity": 1});
}

function showSmallTopNav() {
  $('#small_nav').removeClass('display_none');
  $('#small_nav').addClass('display_block');
  $('#expand_nav').css({"opacity": 0.8});
}

function hideExpandMe() {
  $('#expand_me').removeClass('display_block');
  $('#expand_me').addClass('display_none');
  $('#me').css({"opacity": 1});
  $('#title_expand').css({"opacity": 1});
}

function showExpandMe() {
  $('#expand_me').removeClass('display_none');
  $('#expand_me').addClass('display_block');
  $('#me').css({"opacity": 0.8});
  $('#title_expand').css({"opacity": 0.8});
}

function showExpandMoment() {
  $('#expand_moment').removeClass('display_none');
  $('#expand_moment').addClass('display_block');
}

function hideExpandMoment() {
  $('#expand_moment').removeClass('display_block');
  $('#expand_moment').addClass('display_none');
  $('#moment').css({"opacity": 1});
  $('#title_expand').css({"opacity": 1});
}

function setHeight() {
  var the_height = $('#header').height();
  $('#header_space').css({"height": the_height});
}