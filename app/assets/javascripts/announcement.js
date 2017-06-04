function showAnnouncement() {
  $("#announcement").removeClass("display_none");
  $("#announcement").addClass("display_block");
}

function scrollToLocaleToggle() {
  $("html, body").animate({ scrollTop: $("#locale_toggle").offset().top }, 1000);
}

function spanishTranslations() {
  if ($("body").hasClass("pages home") && $("html").attr("lang") === "en") {
    $("#announcement").html("More communities need mental health support. Our site is now available in <span id=\"spanish_translations_anchor\" class=\"anchor\">Español</span>!");
    showAnnouncement();
  }
}

var onReadyAnnouncement = function() {
  spanishTranslations();
  $("#spanish_translations_anchor").click(function() {
    scrollToLocaleToggle();
  });
};

$(document).on("page:load ready", onReadyAnnouncement);
