function showAnnouncement() {
  $("#announcement").removeClass("display_none");
  $("#announcement").addClass("display_block");
}

function scrollToLocaleToggle() {
  $("html, body").animate({ scrollTop: $("#locale_toggle").offset().top }, 1000);
}

function translationsAnnouncement() {
  if ($("body").hasClass("pages home") && $("html").attr("lang") === "en") {
    $("#announcement").html("More communities need mental health support. Our site is now available in <span id=\"translations_anchor\" class=\"anchor\">Español and Português</span>!");
    showAnnouncement();
  }
}

var onReadyAnnouncement = function() {
  translationsAnnouncement();
  $("#translations_anchor").click(function() {
    scrollToLocaleToggle();
  });
};

$(document).on("page:load ready", onReadyAnnouncement);
