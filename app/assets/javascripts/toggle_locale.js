function whenSignedOut(locale, previousLocale) {
	if (locale !== previousLocale) {
		window.localStorage.setItem("locale", locale);
		var href = window.location.href.split("?")[0];
		window.location.replace(href + "?locale=" + locale);
	} else {
		window.localStorage.setItem("locale", previousLocale);
	}
}

function toggleLocale(locale, previousLocale) {
	$.ajax({
		url: "/toggle_locale",
		data: {
			locale: locale
		}
	}).done(function(data) {
		if (data.signed_in_no_reload) {
			window.localStorage.setItem("locale", data.signed_in_no_reload);
		} else if (data.signed_in_reload) {
			window.localStorage.setItem("locale", data.signed_in_reload);
			window.location.reload();
		} else {
			whenSignedOut(locale, previousLocale);
		}
	});
}

var onReadyToggleLocale = function() {
  var locale = window.localStorage.getItem("locale");
  toggleLocale(locale, $("#locale").val());
	$("#locale").change(function() {
		if ($(this).val()) {
			var previousLocale = locale;
			window.localStorage.setItem("locale", $(this).val());
			locale = window.localStorage.getItem("locale");
			toggleLocale(locale, previousLocale);
		}
	});
}

$(document).on("page:load ready", onReadyToggleLocale);
