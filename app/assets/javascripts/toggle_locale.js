function whenSignedOut(locale, previousLocale) {
	if (locale !== previousLocale) {
		window.document.cookie = "locale=" + locale;
		var href = window.location.href.split("?")[0];
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
			window.document.cookie = "locale=" + data.signed_in_no_reload;
		} else if (data.signed_in_reload) {
			window.document.cookie = "locale=" + data.signed_in_reload;
			window.location.reload();
		} else {
			whenSignedOut(locale, previousLocale);
		}
	});
}

var onReadyToggleLocale = function() {
	$("#locale").change(function() {
		if ($(this).val()) {
			var previousLocale = getCookie("locale");
			var updatedLocale = $(this).val();
			window.document.cookie = "locale=" + updatedLocale;
			toggleLocale(updatedLocale, previousLocale);
		}
	});
};

$(document).on("page:load ready", onReadyToggleLocale);
