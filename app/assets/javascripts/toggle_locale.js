function whenSignedOut(locale, previousLocale) {
	if (locale !== previousLocale) {
		window.document.cookie = "locale=" + locale;
		window.location.reload();
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
			Cookies.set("locale", data.signed_in_no_reload);
		} else if (data.signed_in_reload) {
			Cookies.set("locale", data.signed_in_reload);
			window.location.reload();
		} else {
			whenSignedOut(locale, previousLocale);
		}
	});
}

onReadyToggleLocale = function() {
	$("#locale").change(function() {
		if ($(this).val()) {
			var previousLocale = Cookies.get("locale");
			var updatedLocale = $(this).val();
			Cookies.set("locale", updatedLocale);
			toggleLocale(updatedLocale, previousLocale);
		}
	});
};

$(document).on("turbolinks:load", onReadyToggleLocale);
