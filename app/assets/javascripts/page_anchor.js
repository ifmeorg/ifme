var onReadyPageAnchor = function() {
  if ($(".page_anchor").length > 0) {
    $("html, body").animate({ scrollTop: $(".page_anchor").offset().top - $("#header").height()}, 1000);
  }
};

$(document).on("page:load ready", onReadyPageAnchor);
