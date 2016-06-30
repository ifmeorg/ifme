var onReadyHeader = function() {
  setHeight();

  var click_flag = { value: 0 };

  $('.expand_button').click(click_flag, expandButton);

  $('#expand_nav').click(function() {
    hideExpandMe();

    if ($('#small_nav').hasClass('display_none')) {
      showSmallTopNav();
    } else {
      hideSmallTopNav();
    }
  });

  $('.expand_moment_button').mouseover(click_flag,expandMomentMouseover);

  $('#header').mouseleave(headerMouseLeave);


  $(window).resize(function () {
    setHeight();
  });
}

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

function expandButton(event) {
  hideSmallTopNav();
  // even.data.value -> how many times was this function called?
  // if even number of times -> show expand_me
  // otherwise -> hide expand_me
  if (event.data.value % 2 == 0) {
    showExpandMe();
  } else {
    hideExpandMe();
  }
  setHeight();
  event.data.value++;
}

function headerMouseLeave() {
  if ($('#expand_moment').length && $('#expand_moment').hasClass('display_block')) {
    hideExpandMoment();
    setHeight();
  }
}

function expandMomentMouseover(click_flag) {
  if ($('#expand_moment').hasClass('display_none')) {
    showExpandMoment();

    if ($('#expand_me').hasClass('display_block')) {
      click_flag.value++;
    }

    hideExpandMe();
    setHeight();
  }
}

$(document).on("page:load ready", onReadyHeader);
