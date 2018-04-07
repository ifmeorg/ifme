function toggleVisibility(id, show) {
  var classToRemove = show ? 'display_none' : 'display_block';
  var classToAdd = show ? 'display_block' : 'display_none';
  $('#' + id).removeClass(classToRemove);
  $('#' + id).addClass(classToAdd);
}

function hideSmallTopNav() {
  toggleVisibility('small_nav', false);
  $('#expand_nav').css({"opacity": 1});
}

function showSmallTopNav() {
  toggleVisibility('small_nav', true);
  $('#expand_nav').css({"opacity": 0.8});
}

function hideExpand(name) {
  toggleVisibility('expand_' + name, false);
  $('#' + name).css({"opacity": 1});
  $('#title_expand').css({"opacity": 1});
}

function hideExpandMe() {
  hideExpand('me');
}

function hideExpandMoment() {
  hideExpand('moment');
}

function showExpandMoment() {
  toggleVisibility('expand_moment', true);
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
  $('#title_expand .expand').toggleClass("fa-sort-down");
  $('#title_expand .expand').toggleClass("fa-sort-up");
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

loadPage(onReadyHeader);
