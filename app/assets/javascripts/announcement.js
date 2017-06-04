function showAnnouncement() {
  $("#announcement").removeClass("display_none");
  $("#announcement").addClass("display_block");
}

function spanishTranslations() {
  if ($("body").hasClass("pages home") && $("html").attr("lang") === "en") {
    $("#announcement").html("More communities need mental health support. Our site is now available in <a href=\"#language_links\">Español</a>!");
    showAnnouncement();
  }
}

var onReadyAnnouncement = function() {
	spanishTranslations();
};

$(document).on("page:load ready", onReadyAnnouncement);
