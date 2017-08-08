function scrollToBackToTop() {
  $("html, body").animate({ scrollTop: 0 }, 1000);
}

var onReadyBackToTop = function() {
  $(".back_to_top").click(function() {
    scrollToBackToTop();
  });
};

$(document).on("turbolinks:load", onReadyBackToTop);
