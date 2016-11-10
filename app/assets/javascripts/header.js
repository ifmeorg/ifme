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

function expandButton() {
  hideSmallTopNav();
  $('#expand_me').toggleClass("display_none");
  $('#me').toggleClass('dim');
  $('#title_expand').toggleClass('dim');
  setHeight();
}

function headerMouseLeave() {
  if ($('#expand_moment').length && $('#expand_moment').hasClass('display_block')) {
    hideExpandMoment();
    setHeight();
  }
}

function expandMomentMouseover() {
  if ($('#expand_moment').hasClass('display_none')) {
    showExpandMoment();

    hideExpandMe();
    setHeight();
  }
}

var onReadyHeader = function() {
  setHeight();

  $('.expand_button').click(expandButton);

  //mobile menu toggling
  $('#expand_nav').click(function() {
    if ($('#small_nav').hasClass('display_none')) {
      showSmallTopNav();
    } else {
      hideSmallTopNav();
    }
    setHeight();
  });

  $('.expand_moment_button').mouseover(expandMomentMouseover);

  $('#header').mouseleave(headerMouseLeave);

  $(window).resize(function () {
    setHeight();
  });
};

$(document).on("page:load ready", onReadyHeader);
