function setInputSize(id) {
  var length = $(id).attr("placeholder").length;
  $(id).attr("size", length);
}

var onReadyPlaceholderInputSize = function() {
  if ($("body").hasClass("allies index")) {
    setInputSize("#search_email");
  }
};

$(document).on("page:load ready", onReadyPlaceholderInputSize);
