function scrollToPageAnchor() {
  $("html, body").animate({ scrollTop: $(".page_anchor").offset().top - $("#header").height()}, 1000);
}

var onReadyPageAnchor = function() {
  if ($(".page_anchor").length > 0) {
    scrollToPageAnchor();
  }
};

$(document).on("page:load ready", onReadyPageAnchor);
